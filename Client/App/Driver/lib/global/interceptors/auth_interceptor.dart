import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  String? accessToken;
  String? refreshToken;

  AuthInterceptor(this._dio);

  // Hàm để đặt lại Access Token và Refresh Token
  void resetTokens(String? newAccessToken, String? newRefreshToken) {
    accessToken = newAccessToken;
    refreshToken = newRefreshToken;
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Kiểm tra và thêm Access Token vào tiêu đề yêu cầu
    accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NGYxNzA5YTBjNGNlMWRiODc3ZmIwODMiLCJ1c2VyVHlwZSI6ImRyaXZlciIsImlhdCI6MTY5Mzg1MTI0NSwiZXhwIjoxNjkzODUxODQ1fQ.zDPmq-n4-EV2xnvWZVp5V3kccV03PNLSoSxQ-TAXgDM';
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Xử lý phản hồi ở đây (ví dụ: kiểm tra xác thực, làm mới Access Token)
    if (response.statusCode == 401) {}

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {}

    super.onError(err, handler);
  }

  // Hàm để làm mới Access Token bằng Refresh Token (điều này cần được triển khai trong ứng dụng của bạn)
  Future<String?> refreshNewToken() async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/api/authen/refresh-token',
        data: {
          'refresh_token': refreshToken,
        },
      );

      final newAccessToken = response.data['access_token'];
      resetTokens(newAccessToken, refreshToken);
      return newAccessToken;
    } catch (error) {
      return null;
    }
  }
}
