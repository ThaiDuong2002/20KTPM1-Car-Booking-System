import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/booking/confirm_booking/bloc_payment_method/payment_method_event.dart';
import 'package:user/presentation/booking/confirm_booking/bloc_payment_method/payment_method_state.dart';
import 'package:user/presentation/booking/confirm_booking/model/payment_method.dart';
import 'package:user/presentation/booking/in_progress/model/promotion_model.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEventFetchData>(getData);
  }

  Future<void> getData(PaymentMethodEventFetchData event,
      Emitter<PaymentMethodState> emit) async {
    try {
      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final payment_method =
          await networkModule.provideDio().get('/prices/payment_method');

      final data = jsonDecode(payment_method.toString())['data'];

      List<PaymentMethod> data_method = [];
      print(data);
      data.forEach((element) {
        String path = "";
        String slug_name = "";
        if (element['name'] == "momo") {
          slug_name = "Momo";
          path = "assets/images/icons/momo.png";
        }
        if (element['name'] == "zalo") {
            slug_name = "ZaloPay";
          path = "assets/images/icons/zalo.png";
        }
        if (element['name'] == "direct") {
           slug_name = "Thanh toán trực tiếp";
          path = "assets/images/icons/direct.png";
        }
        data_method.add(PaymentMethod(
          name: slug_name,
          description: "123",
          image: path,
          id: element['_id'],
        ));
      });

      emit(PaymentMethodSuccess(data: data_method));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());

      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      print(e.toString());
    }
  }
}
