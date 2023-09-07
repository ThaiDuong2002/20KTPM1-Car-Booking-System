import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/booking/confirm_booking/model/item_confirm_booking.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';
import 'confirm_booking_event.dart';
import 'confirm_booking_state.dart';

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    on<ConfirmBookinggetData>(getData);
  }

  Future<void> getData(
      ConfirmBookinggetData event, Emitter<ConfirmBookingState> emit) async {
    try {
      emit(ConfirmBookingLoading());

      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final vihcles =
          await networkModule.provideDio().get('/driver/vehicle/list');

      print(vihcles);

      final data_vihcle = jsonDecode(vihcles.toString());

      List<ItemConfirmBooking> data = [];
      print("Distnace"+ event.distance.toString());
      if (event.distance > 100){
        event.distance /= 1000;
      }
      for (var element in data_vihcle['data']) {
        final prices =
            await networkModule.provideDio().get('/prices/fee', data: {
          "distance": event.distance,
          "time": "2023-09-04T05:30:00",
          "tripType": element['name'],
        });
        final prices_data = jsonDecode(prices.toString());
        var path = "";
        if (element['name'] == "Car") {
          path = "assets/images/home/car.png";
        }
        if (element['name'] == "Motorbike") {
          path = "assets/images/home/bike.png";
        }
        final trip_type = data_vihcle['data'][0]['tripType'];
        data.add(ItemConfirmBooking(
            pathIamge: path,
            nameVihcle: element['name'],
            priceVihcle: prices_data['data'].toString(),
            descriptionVihcle: "123"));
      }
      data.sort((a, b) => a.priceVihcle.compareTo(b.priceVihcle));

      print(data);
      await Future.delayed(Duration(seconds: 2));
      emit(ConfirmBookingSuccess(data: data));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      emit(ConfirmBookingLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ConfirmBookingFailure(message: data['message']));
    } catch (e) {
      print(e.toString());
    }
  }
}
