import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/auth_endpoint.dart';
import 'package:driver/main.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  String? accessToken;
  String? refreshToken;

  AuthInterceptor(this._dio);

  // Hàm để đặt lại Access Token và Refresh Token
  void resetTokens(String? newAccessToken, String? newRefreshToken) {
    accessToken = newAccessToken;
    refreshToken = newRefreshToken;
    secureStorage.write(key: 'accessToken', value: accessToken);
    secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Kiểm tra và thêm Access Token vào tiêu đề yêu cầu
    accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers['x-user-role'] = 'driver';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Xử lý phản hồi ở đây (ví dụ: kiểm tra xác thực, làm mới Access Token)
    if (response.statusCode == 401) {
      await refreshNewToken();
    }

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {}

    super.onError(err, handler);
  }

  // Hàm để làm mới Access Token bằng Refresh Token (điều này cần được triển khai trong ứng dụng của bạn)
  Future<String?> refreshNewToken() async {
    refreshToken = await secureStorage.read(key: 'refreshToken');
    try {
      final response = await _dio.post(
        refreshTokenApi,
        data: {
          'refreshToken': refreshToken,
        },
      );
      final dataJson = jsonDecode(response.toString());
      final data = dataJson['data'];
      resetTokens(data['accessToken'], data['refreshToken']);
      return data['accessToken'];
    } catch (error) {
      return null;
    }
  }
}
