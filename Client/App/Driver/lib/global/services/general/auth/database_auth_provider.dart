import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/auth_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/services/exceptions/auth_exception.dart';
import 'package:driver/global/services/general/auth/auth_provider.dart';
import 'package:driver/global/services/general/auth/auth_user.dart';
import 'package:driver/main.dart';
import 'package:flutter/foundation.dart';

class DatabaseAuthProvider implements AuthProvider {
  final Dio _dio = Dio();
  static AuthUser? _currentUser;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Future<AuthUser> logIn({
    required String identifier,
    required String password,
  }) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final userFetchData = await _dio.post(loginApi, data: {
        'identifier': identifier,
        'password': password,
      });

      final dataJsonUser = jsonDecode(userFetchData.toString());
      debugPrint(dataJsonUser['status'].toString());
      if (userFetchData.statusCode == 200) {
        final data = dataJsonUser['data'];
        final userData = data['user'];
        if (userData['userRole'] == 'driver') {
          secureStorage.write(key: 'userId', value: userData['_id']);
          secureStorage.write(key: 'userRole', value: userData['userRole']);
          secureStorage.write(key: 'userEmail', value: userData['email']);
          secureStorage.write(key: 'userFirstName', value: userData['firstname']);
          secureStorage.write(key: 'userLastName', value: userData['lastname']);
          secureStorage.write(key: 'userPhone', value: userData['phone']);
          secureStorage.write(key: 'userAvatar', value: userData['avatar']);
          secureStorage.write(key: 'accessToken', value: data['accessToken']);
          secureStorage.write(key: 'refreshToken', value: data['accessToken']);
          final user = AuthUser.fromDatabase(userData);
          _currentUser = user;
          return user;
        } else {
          throw UserNotFoundAuthException();
        }
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = currentUser;
    if (user != null) {
      _currentUser = null;
      await secureStorage.deleteAll();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> signUp(
    int capacity, {
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
    required String avatar,
    required String dob,
    required String vehicleImage,
    required String vehicleType,
    required String vehicleColor,
    required String licensePlate,
    required String licenseFrontImage,
    required String licenseBackImage,
  }) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.post(
        registerApi,
        data: {
          'email': email,
          'password': password,
          'firstname': firstname,
          'lastname': lastname,
          'phone': phone,
          'avatar': avatar,
          'dob': dob,
          'vehicleImage': vehicleImage,
          'vehicleType': vehicleType,
          'vehicleColor': vehicleColor,
          'licensePlate': licensePlate,
          'licenseFrontImage': licenseFrontImage,
          'licenseBackImage': licenseBackImage,
          'capacity': capacity,
        },
      );
      throw GenericAuthException();
    } catch (e) {
      throw GenericAuthException();
    }
  }
}
