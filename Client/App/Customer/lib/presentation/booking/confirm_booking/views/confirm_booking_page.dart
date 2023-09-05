import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../../model_gobal/pick_des.dart';
import '../../../widget/custom_text.dart';

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
    _markers = <Marker>[
      Marker(
        markerId: const MarkerId('1'),
        draggable: true,
        position: currentPosition,
        infoWindow: const InfoWindow(title: 'Ví trị hiện tại'),
      ),
      Marker(
        markerId: const MarkerId('1'),
        draggable: true,
        position: desPosition,
        infoWindow: const InfoWindow(title: 'Vị trí điểm đến'),
      ),
    ];

    drawPolylines();
  }

  drawPolylines() async {
    List<LatLng> routePoints = await fetchRoutePoints(currentPosition,
        desPosition, "FhOh9cfL6BNKsqwbKfkj7y3h26BMDQRFoTAO8Fb8");
    setState(() {});
    polylines.add(Polyline(
      polylineId: PolylineId(currentPosition.toString()),
      visible: true,
      width: 5, //width of polyline
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
                Expanded(
                    child: ListView.builder(
                  itemCount: vihicles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextCustom(
                          text: vihicles[index]["name"]!,
                          color: COLOR_TEXT_BLACK,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                      subtitle: TextCustom(
                          text: vihicles[index]["capacity"]!,
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
            top: 470,
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
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: COLOR_TEXT_BLACK,
                          size: 20,
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
                        Icon(
                          Icons.location_on,
                          color: COLOR_TEXT_BLACK,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextCustom(
                              text: widget.data.pickUpLocation!.name.toString(),
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
