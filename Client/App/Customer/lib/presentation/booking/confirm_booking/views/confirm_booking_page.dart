import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:provider/provider.dart';
import 'package:user/presentation/booking/confirm_booking/bloc_payment_method/payment_method_bloc.dart';
import 'package:user/presentation/booking/confirm_booking/blocs/confirm_booking_event.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_bloc.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_state.dart';
import 'package:user/presentation/widget/loading.dart';
import 'dart:ui' as ui;
import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../../model_gobal/pick_des.dart';
import '../../../widget/custom_text.dart';
import '../../decode/flexible_polyline.dart';
import '../../in_progress/bloc_promotion/promotion_event.dart';
import '../bloc_payment_method/payment_method_state.dart';
import '../blocs/confirm_booking_bloc.dart';
import '../blocs/confirm_booking_state.dart';

import 'package:intl/intl.dart';

String formatCurrency(int number) {
  final formatter = NumberFormat('#,###', 'en_US');
  return '${formatter.format(number)} VND';
}

class ConfirmBookingPage extends StatefulWidget {
  final PickUpAndDestication data;
  const ConfirmBookingPage({super.key, required this.data});

  @override
  State<ConfirmBookingPage> createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  List<Marker> _markers = <Marker>[];
  late LatLng currentPosition;
  late LatLng desPosition;
  late LatLng currentPositionCamera;
  static String id_promotion = '';
  static double discount_promotion = 0;
  BitmapDescriptor? customIcon;
  int checkPaymentMethod = 0;
  BitmapDescriptor? customIcon2;
  late double driverToPickupBearing;
  int inittialCameraDistance = 16;
  Color selected = Colors.blue;

  // Cargar imagen del Marker
  Future<void> getIcons() async {
    var custom = await getImages("assets/images/icon_marker.png", 150);
    var custom02 =
        await getImages("assets/images/icon_marker_destination.png", 150);
    customIcon = BitmapDescriptor.fromBytes(custom);
    customIcon2 = BitmapDescriptor.fromBytes(custom02);
    _markers = <Marker>[
      Marker(
        markerId: const MarkerId('1'),
        draggable: true,
        icon: customIcon!,
        position: currentPosition,
        infoWindow: const InfoWindow(title: 'Ví trị hiện tại'),
      ),
      Marker(
        markerId: const MarkerId('2'),
        draggable: true,
        position: desPosition,
        icon: customIcon2!,
        infoWindow: const InfoWindow(title: 'Vị trí điểm đến'),
      ),
    ];
    setState(() {});
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  double radiansToDegrees(double radians) {
    return radians * (180 / pi);
  }

  double calculateBearing(LatLng from, LatLng to) {
    double lat1 = from.latitude;
    double lon1 = from.longitude;
    double lat2 = to.latitude;
    double lon2 = to.longitude;

    double deltaLon = lon2 - lon1;

    double y = sin(deltaLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(deltaLon);

    double bearing = atan2(y, x);
    bearing = radiansToDegrees(bearing);
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  Set<Polyline> polylines = {};

  static const vihicles = [
    {
      "image": "123",
      "name": "Xe máy",
      "capacity": "1 chỗ ",
      "time_estimate": "1-7 phút",
      "price": "10.000đ",
    },
    {
      "image": "123",
      "name": "Ô tô",
      "capacity": "4 chỗ ",
      "time_estimate": "5-9 phút",
      "price": "20.000đ",
    },
    {
      "image": "123",
      "name": "Ô tô",
      "capacity": "7 chỗ ",
      "time_estimate": "10-12 phút",
      "price": "25.000đ",
    }
  ];

  Set<Circle> circles = {};
  String? selectedOption;

  Future<List<LatLng>> fetchRoutePoints(
      LatLng start, LatLng end, String apiKey) async {
    Dio dio = Dio();
    final String url = 'https://rsapi.goong.io/Direction'
        '?origin=${start.latitude},${start.longitude}'
        '&destination=${end.latitude},${end.longitude}'
        '&vehicle=car'
        '&api_key=$apiKey';

    final response = await dio.get(url);
    print(response);
    if (response.statusCode == 200) {
      List<LatLng> endLocations = [];

      // Lấy danh sách các steps
      List steps = response.data['routes'][0]['legs'][0]['steps'];

      // Lấy end_location từ mỗi step và thêm vào danh sách endLocations
      for (var step in steps) {
        var location_end = step['end_location'];
        var location_start = step['start_location'];
        endLocations.add(LatLng(location_start['lat'], location_start['lng']));
        endLocations.add(LatLng(location_end['lat'], location_end['lng']));
      }

      return endLocations;
    } else {
      throw Exception('Failed to load end locations from API');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPosition = LatLng(widget.data.currentPosition!.latitude!,
        widget.data.currentPosition!.longitude!);
    desPosition = LatLng(
        widget.data.pickUpLocation!.lat, widget.data.pickUpLocation!.lng);
    currentPositionCamera = LatLng(
      widget.data.currentPosition!.latitude! - 0.001,
      widget.data.currentPosition!.longitude!,
    );
    circles.add(Circle(
      circleId: const CircleId("1"),
      center: currentPosition,
      radius: 100,
      fillColor: Colors.blueAccent.withOpacity(0.3),
      strokeColor: Colors.blueAccent.withOpacity(0.8),
      strokeWidth: 1,
    ));
    driverToPickupBearing = calculateBearing(currentPosition, desPosition);
    // Lấy hướng la bàn (bearing)

    print(driverToPickupBearing);
    getIcons();

    drawPolyliness();
    if (widget.data.pickUpLocation!.distance > 50 &&
        widget.data.pickUpLocation!.distance < 500) {
      inittialCameraDistance = 17;
    }
    if (widget.data.pickUpLocation!.distance < 20) {
      inittialCameraDistance = 15;
    }
    if (widget.data.pickUpLocation!.distance > 40 &&
        widget.data.pickUpLocation!.distance < 60) {
      inittialCameraDistance = 15;
    }
  }

  Future<List<LatLng>> fetchRouteCoordinates(
      LatLng origin, LatLng destination, String apiKey) async {
    try {
      final url =
          'https://router.hereapi.com/v8/routes?origin=${origin.latitude},${origin.longitude}&transportMode=car&destination=${destination.latitude},${destination.longitude};sideOfStreetHint=${origin.latitude},${origin.longitude};matchSideOfStreet=always&return=polyline,summary&apikey=$apiKey';

      final Dio dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final polyline = response.data['routes'][0]['sections'][0]['polyline'];
        final coords = FlexiblePolyline.decode(polyline);
        List<LatLng> data = [];
        coords.forEach((element) {
          print(element);
          data.add(LatLng(element.lat, element.lng));
        });
        return data;
      } else {
        throw Exception('Failed to load route coordinates');
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  drawPolyliness() async {
    List<LatLng> routePoints = await fetchRouteCoordinates(currentPosition,
        desPosition, "hEw3XwDy1W81P-plM4aqi0guc50YBNmuKSo9uDkaYvw");
    setState(() {});
    polylines.add(Polyline(
      polylineId: PolylineId(currentPosition.toString()),
      visible: true,

      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.round,
      width: 8, //width of polyline
      points: routePoints,
      color: Colors.deepOrangeAccent, //color of polyline
    ));
  }

  drawPolylines() async {
    List<LatLng> routePoints = await fetchRoutePoints(currentPosition,
        desPosition, "FhOh9cfL6BNKsqwbKfkj7y3h26BMDQRFoTAO8Fb8");
    setState(() {});
    polylines.add(Polyline(
      polylineId: PolylineId(currentPosition.toString()),
      visible: true,

      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.round,
      width: 8, //width of polyline
      points: routePoints,
      color: Colors.deepOrangeAccent, //color of polyline
    ));
  }

  double containerHeight = 300.0; // initial height

  @override
  Widget build(BuildContext context) {
    print("tress ");
    print(widget.data);
    print("tress hhihi");

    return BlocListener<ConfirmBookingBloc, ConfirmBookingState>(
      bloc: ConfirmBookingBloc(),
      listener: (context, state) {
        // TODO: implement listener
        if (state is ConfirmBookingHaveDriver) {
          Navigator.pushNamed(context, '/inProgressPage',
              arguments: widget.data);
        }
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: AnimatedContainer(
          height: 350,
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu shadow
                spreadRadius: 0.2, // Bán kính của shadow
                blurRadius: 0.2, // Độ mờ của shadow
                offset: const Offset(0, -4), // Vị trí của shadow (phía trên)
              )
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
            builder: (context, state) {
              print(state);
              if (state is ConfirmBookingWattingDriver) {
                return Column(children: [
                  Center(
                    child: Lottie.asset(
                      'assets/find_driver.json',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const TextCustom(
                      textAlign: TextAlign.center,
                      text: "Đang tìm tài xế phù hợp với bạn",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w500)
                ]);
              }
              if (state is ConfirmBookingLoading) {
                return Column(children: [
                  Center(
                    child: Lottie.asset(
                      'assets/loading.json',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const TextCustom(
                      textAlign: TextAlign.center,
                      text: "Hệ thống đang tính toán giá tiền",
                      color: COLOR_TEXT_MAIN,
                      fontSize: FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w500)
                ]);
              }
              if (state is ConfirmBookingSuccess) {
                int selectedIndex = 0; // Mặc định không có mục nào được chọn
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextCustom(
                                text: "Phương tiện di chuyển",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_LARGE,
                                fontWeight: FontWeight.w600),
                            InkWell(
                              onTap: () {
                                print("123");
                                // Provider.of<PromotionBloc>(context,
                                //         listen: false)
                                //     .add(PromotionEventFetchData());
                                final confirmBookingBloc =
                                    BlocProvider.of<ConfirmBookingBloc>(
                                        context);

                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      print("!23");
                                      return BlocProvider.value(
                                        value: confirmBookingBloc,
                                        child: BlocBuilder<PromotionBloc,
                                            PromotionState>(
                                          builder: (contexts, statePromotion) {
                                            if (statePromotion
                                                is PromotionStateInitial) {
                                              return const SizedBox();
                                            }
                                            if (statePromotion
                                                is PromotionStateLoading) {
                                              return SizedBox(
                                                  width: 150,
                                                  height: 300,
                                                  child: LoadingDialog());
                                            }
                                            if (statePromotion
                                                is PromotionStateSuccess) {
                                              int select = -1;
                                              return Container(
                                                height: 500,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                color: Colors.white30,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const TextCustom(
                                                            text:
                                                                "Ưu đãi hiện có",
                                                            color:
                                                                COLOR_TEXT_BLACK,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                COLOR_BLUE_MAIN,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              print("123");

                                                              confirmBookingBloc.add(
                                                                  ApplyPromotionEvent(
                                                                      data: state
                                                                          .data,
                                                                      promotionId:
                                                                          id_promotion,
                                                                      discount:
                                                                          discount_promotion));

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const TextCustom(
                                                                text: "Áp dụng",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    FONT_SIZE_LARGE,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    StatefulBuilder(
                                                      builder:
                                                          (context, setStates) {
                                                        return ListView.builder(
                                                          itemCount:
                                                              statePromotion
                                                                  .promotionList
                                                                  .length,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setStates(() {
                                                                  select =
                                                                      index;

                                                                  id_promotion =
                                                                      statePromotion
                                                                          .promotionList[
                                                                              index]
                                                                          .id;
                                                                  discount_promotion = statePromotion
                                                                      .promotionList[
                                                                          index]
                                                                      .discount;
                                                                });

                                                                print(
                                                                    "Update rồi");
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                height: 100,
                                                                decoration: BoxDecoration(
                                                                    color: select ==
                                                                            index
                                                                        ? Colors
                                                                            .blue
                                                                            .shade100
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                                child: Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/promotion/3.png',
                                                                        height:
                                                                            80,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        margin: const EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            TextCustom(
                                                                                text: statePromotion.promotionList[index].name,
                                                                                color: COLOR_TEXT_BLACK,
                                                                                fontSize: FONT_SIZE_NORMAL,
                                                                                fontWeight: FontWeight.w600),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            TextCustom(
                                                                                text: statePromotion.promotionList[index].description,
                                                                                color: COLOR_TEXT_MAIN,
                                                                                fontSize: FONT_SIZE_NORMAL,
                                                                                fontWeight: FontWeight.w500),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: COLOR_BLUE_MAIN,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: const TextCustom(
                                    text: "Ưu đãi",
                                    color: Colors.white,
                                    fontSize: FONT_SIZE_LARGE,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        StatefulBuilder(
                          builder: (context, setStates) {
                            return Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: state.data.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setStates(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Colors.blue.shade100
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                state.data[index].pathIamge,
                                                width: 60,
                                                height: 60,
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextCustom(
                                                      text: state.data[index]
                                                          .nameVihcle,
                                                      color: COLOR_TEXT_BLACK,
                                                      fontSize: FONT_SIZE_LARGE,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  TextCustom(
                                                      text: state.data[index]
                                                          .descriptionVihcle
                                                          .toString(),
                                                      color: COLOR_TEXT_BLACK,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  state.data[index]
                                                              .promotionDiscountVihcle ==
                                                          0
                                                      ? SizedBox()
                                                      : Text(
                                                          formatCurrency(double
                                                                      .parse(state
                                                                          .data[
                                                                              index]
                                                                          .priceVihcle)
                                                                  .toInt() +
                                                              (double.parse(state
                                                                          .data[
                                                                              index]
                                                                          .promotionDiscountVihcle
                                                                          .toString()) *
                                                                      double.parse(state
                                                                              .data[index]
                                                                              .priceVihcle)
                                                                          .toInt())
                                                                  .toInt()),
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        ),
                                                  TextCustom(
                                                      text: formatCurrency(
                                                          double.parse(state
                                                                  .data[index]
                                                                  .priceVihcle)
                                                              .toInt()),
                                                      color: COLOR_TEXT_BLACK,
                                                      fontSize: FONT_SIZE_LARGE,
                                                      fontWeight:
                                                          FontWeight.w500)
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              final confirmBookingBloc =
                                  BlocProvider.of<ConfirmBookingBloc>(context);
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: confirmBookingBloc,
                                    child: BlocBuilder<PaymentMethodBloc,
                                        PaymentMethodState>(
                                      builder: (context, state) {
                                        if (state is PaymentMethodInitial) {
                                          return SizedBox(
                                              width: 150,
                                              height: 300,
                                              child: LoadingDialog());
                                        }
                                        if (state is PaymentMethodLoading) {
                                          return SizedBox(
                                              width: 150,
                                              height: 300,
                                              child: LoadingDialog());
                                        }
                                        if (state is PaymentMethodSuccess) {
                                          return Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                height: 350,
                                                child: Column(children: [
                                                  const TextCustom(
                                                      text:
                                                          "Phương thức thanh toán",
                                                      color: COLOR_TEXT_BLACK,
                                                      fontSize: FONT_SIZE_LARGE,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  const SizedBox(height: 10),
                                                  Expanded(
                                                      child: StatefulBuilder(
                                                    builder:
                                                        (context, setStates) {
                                                      return ListView.separated(
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              setStates(() {
                                                                checkPaymentMethod =
                                                                    index;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: checkPaymentMethod ==
                                                                        index
                                                                    ? Colors
                                                                        .blue
                                                                        .shade100
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    state
                                                                        .data[
                                                                            index]
                                                                        .image,
                                                                    width: 50,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  TextCustom(
                                                                      text: state
                                                                          .data[
                                                                              index]
                                                                          .name,
                                                                      color:
                                                                          COLOR_TEXT_BLACK,
                                                                      fontSize:
                                                                          FONT_SIZE_NORMAL,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const Divider(),
                                                        itemCount:
                                                            state.data.length,
                                                      );
                                                    },
                                                  ))
                                                ]),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: COLOR_BLUE_MAIN,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      confirmBookingBloc.add(ConfirmBookingRequestTrip(
                                                          sourceLocation: LatLng(
                                                              10.75539299045719,
                                                              106.68182394229112),
                                                          destinationLocation:
                                                              LatLng(10.761,
                                                                  106.682),
                                                          sourceName:
                                                              "Cà phê Three O'Clock",
                                                          destinationName:
                                                              "Trường Đại Học Sư Phạm",
                                                          distance: 500.10,
                                                          price: 60.2,
                                                          customerName:
                                                              "Thanh Bui ",
                                                          customerPhone:
                                                              "0368826352",
                                                          userId: "456",
                                                          customerImage:
                                                              "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-avatar-sadboiz.jpg",
                                                          type: "Car",
                                                          promotionId:
                                                              "64c49eac0ff5e724021ac421",
                                                          paymentMethodId:
                                                              "64cb6802bf5a624f310fe49e"));

                                                      
                                                    
                                                    },
                                                    child: const Center(
                                                      child: TextCustom(
                                                          text:
                                                              "Chọn thanh toán & Đặt xe",
                                                          color:
                                                              COLOR_TEXT_BLACK,
                                                          fontSize:
                                                              FONT_SIZE_LARGE,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  );
                                },
                              );
                              // BlocProvider.of<ConfirmBookingBloc>(context).add(
                              //     ConfirmBookingRequestTrip(
                              //         sourceLocation: LatLng(
                              //             widget.data.currentPosition!.latitude!,
                              //             widget.data.currentPosition!.longitude!),
                              //         destinationLocation: LatLng(
                              //             widget.data.pickUpLocation!.lat,
                              //             widget.data.pickUpLocation!.lng),
                              //         sourceName: widget.data.currentPosition!.name.toString(),
                              //         destinationName: widget.data.pickUpLocation!.label.toString(),
                              //         distance: widget.data.pickUpLocation!.distance,
                              //         price: double.parse(state.data[selectedIndex].priceVihcle),
                              //         customerName: "Thanh Bui ",
                              //         customerPhone: "0368826352",
                              //         userId: "456",
                              //         customerImage:
                              //             "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-avatar-sadboiz.jpg",
                              //         type: state.data[selectedIndex].nameVihcle,
                              //         promotionId: "64c49eac0ff5e724021ac421",
                              //         paymentMethodId:
                              //             "64cb6802bf5a624f310fe49e"));

                              //     arguments: widget.data);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: COLOR_BLUE_MAIN,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const TextCustom(
                                  textAlign: TextAlign.center,
                                  text: "Thanh toán",
                                  color: Colors.white,
                                  fontSize: FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ))
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: COLOR_TEXT_BLACK,
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: false,
              trafficEnabled: true,
              compassEnabled: false,
              circles: circles,
              myLocationButtonEnabled: true,
              minMaxZoomPreference: const MinMaxZoomPreference(12, 20),
              markers: Set<Marker>.of(_markers),
              onCameraIdle: () {},
              polylines: polylines,
              onCameraMove: (CameraPosition cameraPosition) {
                print(cameraPosition.target.latitude);
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentPositionCamera,
                zoom: inittialCameraDistance.toDouble(),
              ),
            ),
            Positioned(
              top: 460,
              right: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/icon_marker.png",
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: TextCustom(
                                text: "Vị trí của tôi",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade500,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/icon_marker_destination.png",
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextCustom(
                                text: widget.data.pickUpLocation!.label
                                    .toString(),
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
