import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../../model_gobal/pick_des.dart';
import '../../../widget/custom_text.dart';
import '../blocs/confirm_booking_bloc.dart';
import '../blocs/confirm_booking_state.dart';

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
  BitmapDescriptor? customIcon;
  BitmapDescriptor? customIcon2;

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
    getIcons();

    drawPolylines();
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

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: AnimatedContainer(
        height: 350,
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        curve: Curves.easeInOut,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Stack(
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                        text: "Phương tiện di chuyển",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                const Divider(),
                Expanded(child: BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
                  builder: (context, state) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: vihicles.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/home/car.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(
                                          text: "Xe 1",
                                          color: COLOR_TEXT_BLACK,
                                          fontSize: FONT_SIZE_LARGE,
                                          fontWeight: FontWeight.w500),
                                      TextCustom(
                                          text: "Xe 1",
                                          color: COLOR_TEXT_BLACK,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                  Spacer(),
                                  TextCustom(
                                      text: "39.0000 VND",
                                      color: COLOR_TEXT_BLACK,
                                      fontSize: FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.w500)
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ))
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
                      Navigator.pushNamed(context, '/inProgressPage',
                          arguments: widget.data);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: COLOR_BLUE_MAIN,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const TextCustom(
                          textAlign: TextAlign.center,
                          text: "Tiếp tục",
                          color: Colors.white,
                          fontSize: FONT_SIZE_LARGE,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
          ],
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
          size: 18,
          color: COLOR_TEXT_MAIN,
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            trafficEnabled: true,
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
            initialCameraPosition:
                CameraPosition(target: currentPositionCamera, zoom: 16),
          ),
          Positioned(
            top: 460,
            right: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(5),
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
                        SizedBox(width: 10),
                        Expanded(
                          child: TextCustom(
                              text: "Vị trí của tôi",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
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
                        SizedBox(width: 10),
                        Expanded(
                          child: TextCustom(
                              text:
                                  widget.data.pickUpLocation!.label.toString(),
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
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
    );
  }
}
