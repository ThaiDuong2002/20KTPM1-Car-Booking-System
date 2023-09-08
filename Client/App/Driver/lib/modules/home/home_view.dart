import 'dart:async';
import 'dart:ui' as ui;

import 'package:dotted_line/dotted_line.dart';
import 'package:driver/global/services/location/location_service.dart';
import 'package:driver/global/services/socket/socket_booking_service.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/helpers/dialogs/confirm_dialog.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/modules/home/widgets/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _googleMapsApi = dotenv.get('GOOGLE_MAPS_API_KEY', fallback: '');
  Uint8List? icon;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? _mapController;
  final LocationService locationService = LocationService();
  final BookingSocket bookingSocket = BookingSocket();

  final Set<Marker> _markers = {};
  final List<LatLng> _polylineCoordinates = [];

  LatLng? _destinationLocation;

  bool _isOffline = false;
  bool _serviceData = true;

  LatLng? _driverLocation;
  late LatLng? _sourceLocation;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1));
    _driverLocationUpdate();
    getPolyPoints();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void _updateDriverMarker(LatLng position) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 17,
            tilt: 60,
            bearing: 30,
          ),
        ),
      );
    }
  }

  Future _driverLocationUpdate() async {
    Position position = await Geolocator.getCurrentPosition();
    icon = await getImages('assets/images/marker.png', 150);
    setState(() {
      _driverLocation = LatLng(position.latitude, position.longitude);
      _sourceLocation = const LatLng(10.7629, 106.682);
      _destinationLocation = const LatLng(10.7692, 106.688);
      _determinePosition().then(
        (value) => {
          setState(
            () {
              _sourceLocation = LatLng(value.latitude, value.longitude);
            },
          )
        },
      );

      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _driverLocation!,
          icon: BitmapDescriptor.fromBytes(icon!),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('source'),
          position: _sourceLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: _destinationLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      _serviceData = false;
    });
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      _googleMapsApi, // Your Google Map Key
      PointLatLng(_sourceLocation!.latitude, _sourceLocation!.longitude),
      PointLatLng(_destinationLocation!.latitude, _destinationLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
        _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _driverLocationUpdate();
        return true;
      },
      child: ChangeNotifierProvider(
        create: (_) => locationService,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: const DrawerView(),
          appBar: AppBar(
            actions: [
              FlutterSwitch(
                value: _isOffline,
                height: 30,
                width: 60,
                toggleSize: 25,
                borderRadius: 30.0,
                padding: 4.0,
                showOnOff: false,
                switchBorder: Border.all(color: Colors.black.withOpacity(0.4)),
                activeColor: Colors.white,
                activeToggleColor: Colors.green,
                inactiveToggleColor: Colors.grey,
                inactiveColor: Colors.white,
                onToggle: (value) async {
                  await showConfirmDialogCustom(
                    dialogType: DialogType.CONFIRMATION,
                    primaryColor: primaryColor,
                    title: _isOffline
                        ? 'Are you certain you want to go offline?'
                        : 'Are you certain you want to go online?',
                    context,
                    onAccept: (v) {
                      _isOffline = value;
                      locationService.toggleSwitch(value);

                      bookingSocket.toggleSwitch(value);
                      bookingSocket.sendFirstRegister('registerClientId');
                      setState(() {});
                    },
                  );
                },
              ),
              // Switch(
              //   value: _isOffline,
              //   activeColor: Colors.black,
              //   inactiveThumbColor: Colors.red,
              //   onChanged: (value) async {
              //     await showConfirmDialogCustom(
              //       dialogType: DialogType.CONFIRMATION,
              //       primaryColor: primaryColor,
              //       title: _isOffline
              //           ? 'Are you certain you want to go offline?'
              //           : 'Are you certain you want to go online?',
              //       context,
              //       onAccept: (v) {
              //         _isOffline = value;
              //         setState(() {});
              //       },
              //     );
              //   },
              // ),
              const SizedBox(width: 25),
              IconButton(
                icon: const Icon(Icons.notifications_on_outlined),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
          ),
          body: _driverLocation != null
              ? Stack(
                  children: [
                    Consumer<LocationService>(
                      builder: (context, value, child) {
                        try {
                          if (value.currentPosition != null) {
                            _updateDriverMarker(LatLng(
                              value.currentPosition!.latitude,
                              value.currentPosition!.longitude,
                            ));

                            _markers.add(
                              Marker(
                                markerId: const MarkerId('driver'),
                                position: LatLng(
                                  value.currentPosition!.latitude,
                                  value.currentPosition!.longitude,
                                ),
                                icon: BitmapDescriptor.fromBytes(icon!),
                              ),
                            );
                          }
                          return GoogleMap(
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            mapType: MapType.values[1],
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: _driverLocation!,
                              zoom: 17,
                              tilt: 60,
                              bearing: 30,
                            ),
                            markers: _markers,
                            onMapCreated: (mapController) {
                              _mapController = mapController;
                            },
                            polylines: {
                              Polyline(
                                polylineId: const PolylineId("route"),
                                points: _polylineCoordinates,
                                color: const Color.fromARGB(255, 97, 150, 255),
                                width: 6,
                              ),
                            },
                          );
                        } catch (e) {
                          debugPrint('error: $e');
                        }
                        return const SizedBox();
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _isOffline ? Colors.green : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                _isOffline ? 'You are online now' : 'You are offline now',
                                style: secondaryTextStyle(color: primaryColor, size: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _serviceData == true
                        ? SizedBox.expand(
                            child: Stack(
                              children: [
                                DraggableScrollableSheet(
                                  initialChildSize: 0.4,
                                  minChildSize: 0.4,
                                  builder: (context, scrollController) {
                                    scrollController.addListener(() {});
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(defaultRadius),
                                          topRight: Radius.circular(defaultRadius),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 16),
                                                height: 6,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(defaultRadius),
                                                ),
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16),
                                              child: Text(
                                                'Request',
                                                style: primaryTextStyle(size: 18),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 16,
                                                right: 16,
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(defaultRadius),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      blurRadius: 3),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(defaultRadius),
                                                          child: commonCachedNetworkImage(
                                                            'https://thebowdoinharpoon.com/2016/12/14/professor-really-spicing-up-class-as-course-questionnaire-nears/',
                                                            height: 35,
                                                            width: 35,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Thai Duong',
                                                                style: boldTextStyle(size: 14),
                                                              ),
                                                              const SizedBox(height: 4),
                                                              Text(
                                                                '0912345678',
                                                                style: secondaryTextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius: BorderRadius.circular(
                                                                defaultRadius),
                                                          ),
                                                          padding: const EdgeInsets.all(6),
                                                          child: Text(
                                                            '15 min',
                                                            style:
                                                                boldTextStyle(color: Colors.white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Divider(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      height: 0,
                                                      indent: 15,
                                                      endIndent: 15,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Row(
                                                      children: [
                                                        const Column(
                                                          children: [
                                                            Icon(
                                                              Icons.near_me,
                                                              color: Colors.green,
                                                              size: 18,
                                                            ),
                                                            SizedBox(height: 2),
                                                            SizedBox(
                                                              height: 34,
                                                              child: DottedLine(
                                                                direction: Axis.vertical,
                                                                lineLength: double.infinity,
                                                                lineThickness: 2,
                                                                dashLength: 2,
                                                                dashColor: primaryColor,
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Icon(
                                                              Icons.location_on,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                '123 Nguyen Luong Bang, Ho Chi Minh City',
                                                                style: primaryTextStyle(size: 14),
                                                                maxLines: 2,
                                                              ),
                                                              const SizedBox(height: 22),
                                                              Text(
                                                                '123 Nguyen Luong Bang, Ho Chi Minh City',
                                                                style: primaryTextStyle(size: 14),
                                                                maxLines: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Divider(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      height: 0,
                                                      indent: 15,
                                                      endIndent: 15,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: inkWellWidget(
                                                            onTap: () {
                                                              showConfirmDialogCustom(
                                                                dialogType: DialogType.DELETE,
                                                                primaryColor: primaryColor,
                                                                title:
                                                                    'Are you sure want to cancel this request?',
                                                                positiveText: 'Yes',
                                                                negativeText: 'No',
                                                                context,
                                                                onAccept: (v) {},
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(
                                                                    defaultRadius),
                                                                border:
                                                                    Border.all(color: Colors.red),
                                                              ),
                                                              child: Text(
                                                                'Decline',
                                                                style: boldTextStyle(
                                                                    color: Colors.red),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                          child: AppButtonWidget(
                                                            padding: EdgeInsets.zero,
                                                            text: 'Accept',
                                                            shapeBorder: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(
                                                                  defaultRadius),
                                                            ),
                                                            color: primaryColor,
                                                            textStyle:
                                                                boldTextStyle(color: Colors.white),
                                                            onTap: () {
                                                              showConfirmDialogCustom(
                                                                primaryColor: primaryColor,
                                                                dialogType: DialogType.ACCEPT,
                                                                positiveText: 'Yes',
                                                                negativeText: 'No',
                                                                title:
                                                                    'Are you sure want to accept this request?',
                                                                context,
                                                                onAccept: (v) {},
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        : Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(defaultRadius),
                                  topRight: Radius.circular(defaultRadius),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        child: commonCachedNetworkImage(
                                          'https://thebowdoinharpoon.com/2016/12/14/professor-really-spicing-up-class-as-course-questionnaire-nears/',
                                          height: 35,
                                          width: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Thai Duong',
                                              style: boldTextStyle(size: 14),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '0912345678',
                                              style: secondaryTextStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      inkWellWidget(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return const AlertDialog(
                                                contentPadding: EdgeInsets.all(0),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(defaultRadius),
                                          ),
                                          child: Text(
                                            'SOS',
                                            style: boldTextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    height: 0,
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Column(
                                        children: [
                                          Icon(
                                            Icons.near_me,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          SizedBox(height: 2),
                                          SizedBox(
                                            height: 34,
                                            child: DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: double.infinity,
                                              lineThickness: 1,
                                              dashLength: 2,
                                              dashColor: primaryColor,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 2),
                                            Text(
                                              '123 Nguyen Luong Bang, Ho Chi Minh City',
                                              style: primaryTextStyle(size: 14),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 22),
                                            Text(
                                              '123 Nguyen Luong Bang, Ho Chi Minh City',
                                              style: primaryTextStyle(size: 14),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    height: 0,
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      inkWellWidget(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.call,
                                              size: 25,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(height: 4),
                                            Text('Call', style: secondaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                      inkWellWidget(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.chat,
                                              size: 25,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(height: 4),
                                            Text('Chat', style: secondaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  AppButtonWidget(
                                    width: MediaQuery.of(context).size.width,
                                    text: 'Start Ride',
                                    color: primaryColor,
                                    textStyle: boldTextStyle(color: Colors.white),
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),
                          ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
