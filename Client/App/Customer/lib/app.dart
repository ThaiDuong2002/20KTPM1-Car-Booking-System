import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user/model_gobal/mylocation.dart';
import 'package:user/model_gobal/pick_des.dart';
import 'package:user/model_gobal/socket_client.dart';
import 'package:user/presentation/booking/confirm_booking/blocs/confirm_booking_bloc.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_bloc.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_event.dart';
import 'app/routes/route.dart';
import 'data/common/interceptor/authorization_interceptor.dart';
import 'data/common/module/network_module.dart';
import 'data/common/module/shared_pref_module.dart';
import 'package:user/presentation/booking/confirm_booking/bloc_payment_method/payment_method_bloc.dart';
import 'package:user/presentation/booking/confirm_booking/bloc_payment_method/payment_method_event.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyLocation currentLocation;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initializeLocation();
    super.initState();
  }

  _initializeLocation() async {
    var value = await _determinePosition();
    setState(() {
      print("Có vô đây không");
      currentLocation =
          MyLocation(latitude: value.latitude, longitude: value.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => currentLocation,
        ),
        Provider(
          create: (context) => PickUpAndDestication(),
        ),
        Provider(
          create: (context) => SocketService(),
        ),
        Provider(create: (context) {
          SharedPreferenceModule pref = SharedPreferenceModule();
          RequestInterceptor requestInterceptor = RequestInterceptor();
          RequestInterceptor.pref = pref;
          NetworkModule.instance.initialize(interceptor: requestInterceptor);
          NetworkModule networkModule = NetworkModule.instance;
          return networkModule;
        }),
        Provider(create: (context) => SharedPreferenceModule()),
        BlocProvider<PromotionBloc>(
          create: (context) => PromotionBloc()..add(PromotionEventFetchData()),
        ),
     
        BlocProvider<PaymentMethodBloc>(
          create: (context) =>
              PaymentMethodBloc()..add(PaymentMethodEventFetchData()),
        ),
      ],
      child: const MaterialApp(
        title: "BookingModel App",
        // home: SplashPage(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashPage',
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
