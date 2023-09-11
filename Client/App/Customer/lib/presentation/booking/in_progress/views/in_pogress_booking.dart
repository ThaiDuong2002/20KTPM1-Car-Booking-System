import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user/presentation/booking/in_progress/bloc/in_progress_bloc.dart';
import 'package:user/presentation/booking/rating/view/rating_booking_page.dart';
import 'package:user/presentation/widget/loading.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../../model_gobal/pick_des.dart';
import '../../../widget/custom_text.dart';

import '../../decode/flexible_polyline.dart';
import '../bloc/in_progress_state.dart';

class InProgressBooking extends StatefulWidget {
  final PickUpAndDestication data;
  const InProgressBooking({super.key, required this.data});

  @override
  State<InProgressBooking> createState() => _InProgressBookingState();
}

class _InProgressBookingState extends State<InProgressBooking> {
  bool finishtrip = false;
  late LatLng currentPosition;
  late LatLng desPosition;
  bool startRide = false;
  BitmapDescriptor? customIcon01;
  BitmapDescriptor? customIcon02;
  String status = "Tài xế đang đến đón bạn";
  late LatLng currentPositionCamera;
  bool inprogress = false;

  late BitmapDescriptor customIcon;

  GoogleMapController? mapController;

  Future<void> _getCustomIcon() async {
    try {
      String imgurl = "https://www.fluttercampus.com/img/car.png";
      bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
          .buffer
          .asUint8List();
      var custom01 = await getImages("assets/images/icon_marker.png", 150);
      var custom02 =
          await getImages("assets/images/icon_marker_destination.png", 150);
      customIcon01 = BitmapDescriptor.fromBytes(custom01);
      customIcon02 = BitmapDescriptor.fromBytes(custom02);
    } catch (e) {
      print('Error loading asset: $e');
    }
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

  void _updateDriverMarker(LatLng position) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 15,
          ),
        ),
      );
    }
  }

  bool _showDialog = false;
  late Uint8List bytes;
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

    // drawPolylines(currentPosition, desPosition);
    _getCustomIcon();
  }

  Future<void> _showDriverArrivedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Tài xế đã đến điểm đón"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Đóng"))
            ],
          );
        });
  }

  double containerHeight = 300.0; // initial height

  @override
  Widget build(BuildContext context) {
    print("tress ");
    print(widget.data);
    print("tress hhihi");

    List<Marker> _markers = <Marker>[];
    Set<Polyline> _polylines = {};

    return BlocListener<InProgressBloc, InProgressState>(
      listener: (context, state) {
        if (state is InProgressInitial) {
          LoadingDialog();
        }
        if (state is InProgresssStateWaiting) {
          if (!finishtrip) {
            status = "Tài xế đang đến đón bạn";
            _markers.addAll({
              Marker(
                markerId: const MarkerId('0'),
                draggable: true,
                position: currentPosition,
                icon: customIcon01!,
                infoWindow: const InfoWindow(title: 'Ví trị điểm đi'),
              ),
              Marker(
                markerId: const MarkerId('2'),
                icon: BitmapDescriptor.fromBytes(bytes),
                position: state.markersLatLong,
                infoWindow: const InfoWindow(title: 'Vị trí tài xế'),
              ),
            });
            _polylines = state.points;
            if (inprogress == true) {
              status = "Đang trong truyến đi";
            }
          }
        }
        if (state is InProgressStateStartTrip) {
          inprogress = true;

          _markers.addAll({
            Marker(
              markerId: const MarkerId('0'),
              draggable: true,
              position: currentPosition,
              icon: customIcon01!,
              infoWindow: const InfoWindow(title: 'Ví trị điểm đi'),
            ),
            Marker(
              markerId: const MarkerId('1'),
              draggable: true,
              position: desPosition,
              icon: customIcon02!,
              infoWindow: const InfoWindow(title: 'Vị trí điểm đến'),
            ),
            Marker(
              markerId: const MarkerId('2'),
              icon: BitmapDescriptor.fromBytes(bytes),
              position: currentPosition,
              infoWindow: const InfoWindow(title: 'Vị trí tài xế'),
            ),
          });
          _polylines = state.points;
        }
        print("state" + state.toString());
        if (state is InProgressStateFinishTrip) {
          status = "Đã hoàn thành cuốc xe";
          finishtrip = true;
          inprogress = false;
          _polylines.clear();

          _markers.addAll({
            Marker(
              markerId: const MarkerId('0'),
              draggable: true,
              position: currentPosition,
              icon: customIcon01!,
              infoWindow: const InfoWindow(title: 'Ví trị điểm đi'),
            ),
            Marker(
              markerId: const MarkerId('1'),
              draggable: true,
              position: desPosition,
              icon: customIcon02!,
              infoWindow: const InfoWindow(title: 'Vị trí điểm đến'),
            ),
            Marker(
              markerId: const MarkerId('2'),
              icon: BitmapDescriptor.fromBytes(bytes),
              position: currentPosition,
              infoWindow: const InfoWindow(title: 'Vị trí tài xế'),
            ),
          });
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: TextCustom(
                      text: "Hoàn thành cuốc xe",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_LARGE,
                      fontWeight: FontWeight.bold),
                ),
                content: Container(
                  height: 200,
                  child: Column(children: [
                    TextCustom(
                        text: "Bạn có muốn đánh giá tài xế không ?",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_NORMAL,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/homePage");
                            },
                            child: TextCustom(
                                text: "Không",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500)),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RatingPage()));
                            },
                            child: TextCustom(
                                text: "Có",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500)),
                      ],
                    )
                  ]),
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                            text: "Tình trạng cuốc xe",
                            color: COLOR_TEXT_BLACK,
                            fontSize: FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w600),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Center(
                            child: TextCustom(
                                text: "Thông tin tài xế",
                                color: COLOR_TEXT_BLACK,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.network(
                                "https://media.istockphoto.com/id/1297328248/vector/circular-worker-avatar-icon-illustration-police-man-bus-driver.jpg?s=612x612&w=0&k=20&c=rqa0kzR7oAnPotA1chDBKjgquB71aWzhmUHszyGbgsw=",
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                      text: "Bui Quang Thanh",
                                      color: COLOR_TEXT_BLACK,
                                      fontSize: FONT_SIZE_NORMAL,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextCustom(
                                      text: "4.7 sao",
                                      color: COLOR_TEXT_BLACK,
                                      fontSize: FONT_SIZE_NORMAL,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextCustom(
                                      text: "Xe Blade",
                                      color: COLOR_TEXT_BLACK,
                                      fontSize: FONT_SIZE_NORMAL,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextCustom(
                                      text: "59B1- 69405",
                                      color: COLOR_TEXT_BLACK,
                                      fontSize: FONT_SIZE_NORMAL,
                                      fontWeight: FontWeight.w500)
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        print("vô đây");

                                        Navigator.pushNamed(
                                            context, '/chatPagePage');
                                      },
                                      child: Center(
                                        child: TextCustom(
                                            text: "Liên hệ",
                                            color: COLOR_TEXT_MAIN,
                                            fontSize: FONT_SIZE_NORMAL,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: TextCustom(
                                          text: "Gọi điện",
                                          color: COLOR_TEXT_MAIN,
                                          fontSize: FONT_SIZE_NORMAL,
                                          fontWeight: FontWeight.w500),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              height: 40,
                              width: 260,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: COLOR_BLUE_MAIN,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  BlocBuilder<InProgressBloc, InProgressState>(
                                builder: (context, state) {
                                  return Center(
                                    child: TextCustom(
                                        text: status,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ])),
                  ],
                ),
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: COLOR_TEXT_MAIN,
          ),
        ),
        body: BlocBuilder<InProgressBloc, InProgressState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  zoomGesturesEnabled: true,
                  tiltGesturesEnabled: false,
                  trafficEnabled: true,
                  myLocationButtonEnabled: true,
                  minMaxZoomPreference: const MinMaxZoomPreference(12, 20),
                  markers: _markers.toSet(),
                  onCameraIdle: () {},
                  polylines: _polylines,
                  onCameraMove: (CameraPosition cameraPosition) {
                    // print(cameraPosition.target.latitude);
                  },
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: currentPositionCamera, zoom: 15),
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
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade600,
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
                              SizedBox(width: 10),
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
            );
          },
        ),
      ),
    );
  }
}
