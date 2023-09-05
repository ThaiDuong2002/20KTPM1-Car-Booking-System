import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../data/common/module/network_module.dart';
import '../../../data/common/module/shared_pref_module.dart';
import 'authen_event.dart';
import 'authen_state.dart';

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthenBloc() : super(AuthenStateInitial()) {
    // Lắng nghe sự kiện từ socket
    on<AuthenEventSignUp>(signup);
    on<AuthenEventLogin>(login);
  }

  Future<void> signup(
      AuthenEventSignUp event, Emitter<AuthenState> emit) async {
    try {
      emit(AuthenStateLoading());

      SharedPreferenceModule pref = SharedPreferenceModule();

      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;

      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule
          .provideDio()
          .post('/authen/register/customer', data: event.request.toJson());
      print(respone);
      final data = jsonDecode(respone.toString());
      print(data);

      await Future.delayed(Duration(seconds: 2));
      emit(AuthenStateSuccess(message: data['message']));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      emit(AuthenStateLoading());

      await Future.delayed(Duration(seconds: 2));
      emit(AuthenStateFailure(message: data['message']));
    }
  }

  Future<void> login(AuthenEventLogin event, Emitter<AuthenState> emit) async {
    try {
      emit(AuthenStateLoading());

      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule
          .provideDio()
          .post('/authen/login', data: event.request.toJson());

      final data = jsonDecode(respone.toString());
      await pref.saveUserInfo(data['data']);
      await Future.delayed(Duration(seconds: 2));
      emit(AuthenStateLoginSucess(message: data['message']));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      emit(AuthenStateLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(AuthenStateFailure(message: data['message']));
    }
  }
}
