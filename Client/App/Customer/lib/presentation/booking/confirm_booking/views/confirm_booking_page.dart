import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../../model_gobal/mylocation.dart';
import '../../../widget/custom_text.dart';

class ConfirmBookingPage extends StatefulWidget {
  final MyLocation currentLocation;
  const ConfirmBookingPage({super.key, required this.currentLocation});

  @override
  State<ConfirmBookingPage> createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  List<Marker> _markers = <Marker>[];
  late LatLng currentPosition;

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
                        text: "Phương tiện di chuyển",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w500),
                  ],
                ),
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
                          arguments: widget.currentLocation);
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
          color: COLOR_TEXT_MAIN,
        ),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        trafficEnabled: true,
        myLocationButtonEnabled: true,
        minMaxZoomPreference: const MinMaxZoomPreference(12, 20),
        markers: Set<Marker>.of(_markers),
        onCameraIdle: () {},
        onCameraMove: (CameraPosition cameraPosition) {
          print(cameraPosition.target.latitude);
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition:
            CameraPosition(target: currentPosition, zoom: 18),
      ),
    );
  }
}
