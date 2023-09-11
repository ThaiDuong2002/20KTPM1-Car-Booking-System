import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/booking/confirm_booking/model/item_confirm_booking.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';
import '../../../../model_gobal/socket_client.dart';
import 'confirm_booking_event.dart';
import 'confirm_booking_state.dart';

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  SocketService socketService = SocketService();
  Dio dio = Dio();

  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    socketService.socket!.on('accepted_trip_to_customer', (data) {
      print(data);

      add(ConfirmBookingHaveDataDriver());
    });
    on<ConfirmBookinggetData>(getData);
    on<ConfirmBookingRequestTrip>(requestTrip);
    on<ApplyPromotionEvent>(addPromotion);
    on<ConfirmBookingHaveDataDriver>(haveDataDriver);
  }

  Future<void> addPromotion(
      ApplyPromotionEvent event, Emitter<ConfirmBookingState> emit) async {
    emit(ConfirmBookingLoading());

    List<ItemConfirmBooking> data = [];
    for (var element in event.data) {
      print("123 - ?" + element.priceVihcle);
      final price = double.parse(element.priceVihcle) -
          (double.parse(element.priceVihcle) * event.discount);
      print("123 - ?-" + price.toString());
      data.add(ItemConfirmBooking(
          promotionDiscountVihcle: event.discount,
          pathIamge: element.pathIamge,
          nameVihcle: element.nameVihcle,
          priceVihcle: price.toString(),
          descriptionVihcle: element.descriptionVihcle));
    }

    print("1" + event.discount.toString());
    print("2" + event.promotionId);

    data.sort((a, b) => a.priceVihcle.compareTo(b.priceVihcle));

    print("Ônt lho" + data.toString());

    await Future.delayed(Duration(seconds: 2));
    emit(ConfirmBookingSuccess(data: data));
  }

  Future<void> haveDataDriver(ConfirmBookingHaveDataDriver event,
      Emitter<ConfirmBookingState> emit) async {
    emit(ConfirmBookingHaveDriver());
  }

  Future<void> requestTrip(ConfirmBookingRequestTrip event,
      Emitter<ConfirmBookingState> emit) async {
    emit(ConfirmBookingWattingDriver());

    final String url = 'http://10.123.1.139:3013/requestTripFromCustomer';

    
    final data_request = {
      "sourceLocation": {
        "lat": event.sourceLocation.latitude,
        "lng": event.sourceLocation.longitude
      },
      "destinationLocation": {
        "lat": event.destinationLocation.latitude,
        "lng": event.destinationLocation.longitude
      },
      "sourceName": event.sourceName,
      "destinationName": event.destinationName,
      "distance": event.distance,
      "price": event.price,
      "customerName": event.customerName,
      "customerPhone": event.customerPhone,
      "userId": event.userId,
      "customerImage": event.customerImage,
      "type": event.type,
      "promotionId": event.promotionId,
      "paymentMethodId": event.paymentMethodId,
    };

    final response = await dio.get(url, data: data_request);

    // print(response);
    await Future.delayed(Duration(seconds: 2));
    // gọi api request 1 booking mới
    // emit(ConfirmBookingHaveDriver());
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

      print("Distnace" + event.distance.toString());
      if (event.distance > 100) {
        event.distance /= 1000;
      }
      for (var element in data_vihcle['data']) {
        DateTime now = DateTime.now();
        String formattedDate = now.toIso8601String().substring(0, 19);
        final prices =
            await networkModule.provideDio().get('/prices/fee', data: {
          "distance": event.distance,
          "time": formattedDate,
          "tripType": element['name'],
        });
        final prices_data = jsonDecode(prices.toString());
        String name = "Xe máy";
        var path = "assets/images/home/car.png";
        if (element['name'] == "Car" && element['capacity'] == 4) {
          name = "Xe ô tô";
          path = "assets/images/home/car.png";
        }
        if (element['name'] == "Car" && element['capacity'] == 7) {
          name = "Xe ô tô";
          path = "assets/images/home/car_7.png";
        }
        if (element['name'] == "Motorbike") {
          name = "Xe máy";
          path = "assets/images/home/bike.png";
        }

        int price =
            double.parse(prices_data['data']['totalFare'].toString()).round();
        print(price);
        data.add(ItemConfirmBooking(
            promotionDiscountVihcle: 0,
            pathIamge: path,
            nameVihcle: name,
            priceVihcle: price.toString(),
            descriptionVihcle: element['capacity'].toString()));
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
