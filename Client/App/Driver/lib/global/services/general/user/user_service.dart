import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/user_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/user/user_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';

class UserService {
  final Dio _dio = Dio();

  Future<UserModel> getUser() async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.get(getUserApi);
      if (response.statusCode == 200) {
        final userJsonData = jsonDecode(response.toString());
        final userData = userJsonData['data'];
        return UserModel.fromJson(userData);
      }
      throw UnknowFetchingDataException();
    } catch (e) {
      return Future.error(e);
    }
  }
}
