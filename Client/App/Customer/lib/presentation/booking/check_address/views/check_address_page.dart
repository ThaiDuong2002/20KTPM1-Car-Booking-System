import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/model_gobal/pick_des.dart';
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
  bool checkGestorPosition = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPosition = LatLng(
        widget.currentLocation.latitude!, widget.currentLocation.longitude!);
  }

  double containerHeight = 300.0; // initial height

  @override
  Widget build(BuildContext context) {
    print("tress");
    var postion = Provider.of<PickUpAndDestication>(context, listen: false);
    print(postion);
    _markers = <Marker>[
      Marker(
        markerId: const MarkerId('1'),
        draggable: true,
        position: currentPosition,
        infoWindow: const InfoWindow(title: 'Ví trị hiện tại'),
      ),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: !checkGestorPosition
          ? AnimatedContainer(
              height: 350,
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
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
                      Expanded(
                          child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: TextCustom(
                                text: "Điểm đón ${index + 1}",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500),
                            subtitle: TextCustom(
                                text: "Địa chỉ ${index + 1}",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500),
                            trailing: const Icon(Icons.arrow_forward_ios),
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
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                          text: "Đang chọn điểm đón",
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
        initialCameraPosition:
            CameraPosition(target: currentPosition, zoom: 18),
      ),
    );
  }
}
