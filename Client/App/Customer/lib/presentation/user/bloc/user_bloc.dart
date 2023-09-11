import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/user/bloc/user_event.dart';
import 'package:user/presentation/user/bloc/user_state.dart';

import '../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../data/common/module/network_module.dart';
import '../../../data/common/module/shared_pref_module.dart';
import '../model/user.dart';

class UserInformation extends Bloc<UserEvent, UserState> {
  UserInformation() : super(UserStateInitial()) {
    
    on<UserEventFetchData>(fetchData);
  }

  Future<void> fetchData(
      UserEventFetchData event, Emitter<UserState> emit) async {
    try {
      emit(UserStateLoading());
  

      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule.provideDio().get('/customer/me');

      // print(vihcles);

      final information = jsonDecode(respone.toString());

      User currentUser = User(
          firstname: information['data']['firstname'],
          lastname: information['data']['lastname'],
          email: information['data']['email'],
          phone: information['data']['phone'],
          avatar: information['data']['avatar'],
          address: information['data']['address'],
          userRole: information['data']['userRole'],
          userType: information['data']['userType'],
          isDisabled: information['data']['isDisabled'],
          createdAt: information['data']['createdAt'],
          updatedAt: information['data']['updatedAt']);

      emit(UserStateSuccess(information: currentUser));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      print(data);
      await Future.delayed(Duration(seconds: 2));
    } on DioExceptionType catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
