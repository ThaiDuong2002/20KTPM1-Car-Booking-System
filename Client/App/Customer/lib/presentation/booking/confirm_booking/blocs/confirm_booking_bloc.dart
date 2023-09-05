import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';
import 'confirm_booking_event.dart';
import 'confirm_booking_state.dart';

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    on<ConfirmBookingEvent>(getData);
  }

   Future<void> getData(
      ConfirmBookingEvent event, Emitter<ConfirmBookingState> emit) async {
    try {
      emit(ConfirmBookingLoading());

      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule
          .provideDio()
          .post('/authen/login',);

      final data = jsonDecode(respone.toString());
      await pref.saveUserInfo(data['data']);
      await Future.delayed(Duration(seconds: 2));
      emit(ConfirmBookingSuccess(data: data['message']));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      emit(ConfirmBookingLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ConfirmBookingFailure(message: data['message']));
    }
  }
}
