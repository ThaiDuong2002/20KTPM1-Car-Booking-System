import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/model_gobal/pick_des.dart';
import 'package:user/presentation/booking/check_address/blocs/check_address_bloc.dart';
import 'package:user/presentation/booking/check_address/blocs/check_address_state.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../../../model_gobal/mylocation.dart';

class CheckAddressPage extends StatefulWidget {
  final MyLocation currentLocation;
  const CheckAddressPage({Key? key, required this.currentLocation})
      : super(key: key);

  @override
  _CheckAddressPageState createState() => _CheckAddressPageState();
}




class _CheckAddressPageState extends State<CheckAddressPage> {
  List<Marker> _markers = <Marker>[];
  late LatLng currentPosition;
  BitmapDescriptor? customIcon;
  bool checkGestorPosition = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPosition = LatLng(
        widget.currentLocation.latitude!, widget.currentLocation.longitude!);
    getIcons();
  }
  

  // Cargar imagen del Marker
  Future<void> getIcons() async {
    var custom = await getImages("assets/images/icon_marker.png", 150);
    customIcon = BitmapDescriptor.fromBytes(custom);
    _markers = <Marker>[
      Marker(
        markerId: const MarkerId('1'),
        draggable: true,
        position: currentPosition,
        icon: customIcon!,
        infoWindow: const InfoWindow(title: 'Ví trị hiện tại'),
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

  double containerHeight = 300.0; // initial height

  @override
  Widget build(BuildContext context) {
    print("tress");
    var postion = Provider.of<PickUpAndDestication>(context, listen: false);

    print(postion);
    if (customIcon != null) {
      _markers = <Marker>[
        Marker(
          markerId: const MarkerId('1'),
          draggable: true,
          position: currentPosition,
          icon: customIcon!,
          infoWindow: const InfoWindow(title: 'Ví trị hiện tại'),
        ),
      ];
    }

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: !checkGestorPosition
          ? AnimatedContainer(
              height: 350,
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15), // Màu shadow
                    spreadRadius: 0.05, // Bán kính của shadow
                    blurRadius: 0.05, // Độ mờ của shadow
                    offset: Offset(0, -4), // Vị trí của shadow (phía trên)
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Stack(
                children: [
                  BlocListener<CheckAddressBloc, CheckAddressState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    child: Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextCustom(
                                text: "Kiểm tra kĩ điểm đón của bạn",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_LARGE,
                                fontWeight: FontWeight.w600),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: COLOR_BLUE_MAIN,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("Về trang Search page");
                                },
                                child: const TextCustom(
                                    text: "Thay đổi",
                                    color: Colors.white,
                                    fontSize: FONT_SIZE_LARGE,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const TextCustom(
                            text: "Chọn điểm đón thuận tiện nhất từ danh sách",
                            color: COLOR_TEXT_BLACK,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.w600),
                        const Divider(),
                        Expanded(child:
                            BlocBuilder<CheckAddressBloc, CheckAddressState>(
                          builder: (context, state) {
                            if (state is CheckAddressStateLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CheckAddressStateSuccess) {
                              return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: state.searchEntities.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        currentPosition = LatLng(
                                            state.searchEntities[index].lat,
                                            state.searchEntities[index].lng);
                                        checkGestorPosition = false;
                                        containerHeight = 100;

                                        postion.currentPosition?.latitude =
                                            state.searchEntities[index].lat;
                                        postion.currentPosition?.longitude =
                                            state.searchEntities[index].lng;
                                      });
                                    },
                                    tileColor:
                                        index == 0 ? Colors.blue[100] : null,
                                    trailing: index == 0
                                        ? Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: COLOR_BLUE_MAIN,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Icon(Icons.check,
                                                color: Colors.white, size: 18),
                                          ) // Đánh dấu item đầu tiên
                                        : const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          ),
                                    title: TextCustom(
                                        text: state.searchEntities[index].title,
                                        color: COLOR_TEXT_BLACK,
                                        fontSize: FONT_SIZE_NORMAL,
                                        fontWeight: FontWeight.w600),
                                    subtitle: TextCustom(
                                        text: state.searchEntities[index].label,
                                        color: COLOR_TEXT_BLACK,
                                        fontSize: FONT_SIZE_SMALL_X,
                                        fontWeight: FontWeight.w500),
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        ))
                      ],
                    ),
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
                            Navigator.pushNamed(context, '/confirmBookingPage',
                                arguments: postion);
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
            )
          : Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
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
                      TextCustom(
                          text: "Đang chọn điểm đón ...",
                          color: COLOR_TEXT_BLACK,
                          fontSize: FONT_SIZE_LARGE,
                          fontWeight: FontWeight.w600),
                    ]),
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
          color: COLOR_TEXT_BLACK,
        ),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        trafficEnabled: true,
        myLocationButtonEnabled: true,
        minMaxZoomPreference: const MinMaxZoomPreference(12, 20),
        markers: Set<Marker>.of(_markers),
        onCameraIdle: () {
          setState(() {
            checkGestorPosition = false;
            var updateLocation =
                Provider.of<PickUpAndDestication>(context, listen: false);
            final data = MyLocation(
                latitude: currentPosition.latitude,
                longitude: currentPosition.longitude);
            print("Toạ độ" + currentPosition.latitude.toString());
            updateLocation.currentPosition = data;
          });
        },
        onCameraMove: (CameraPosition cameraPosition) {
          print(cameraPosition.target.latitude);

          setState(() {
            currentPosition = cameraPosition
                .target; // Update the marker's position when the camera moves

            checkGestorPosition = true;
          });
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 16,
          tilt: 30,
          bearing: 30.0,
        ),
      ),
    );
  }
}
