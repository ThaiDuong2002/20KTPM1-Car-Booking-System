import 'package:dio/dio.dart';

import '../interceptor/authorization_interceptor.dart';
import '../interceptor/logger_interceptor.dart';
import 'endpoints.dart';

class NetworkModule {
  static final NetworkModule _singleton =
      NetworkModule._internal(Dio(), RequestInterceptor());

  Dio _dio;
  RequestInterceptor requestInterceptor;
  final LoggerInterceptor loggerInterceptor = LoggerInterceptor();

  // Private constructor
  NetworkModule._internal(this._dio, this.requestInterceptor);

  // Initialize the instance with the interceptor
  void initialize({required RequestInterceptor interceptor}) {
    requestInterceptor = interceptor;
    _dio = Dio();
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    _dio.interceptors.add(loggerInterceptor);
  }

  // Factory constructor to return the single instance
  factory NetworkModule() {
    return _singleton;
  }

  // Static method to provide the single instance
  static NetworkModule get instance => _singleton;

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = Endpoints.baseURL;
    opts.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    opts.connectTimeout = Endpoints.connectionTimeout;
    opts.receiveTimeout = Endpoints.receiveTimeout;
    opts.validateStatus = (_) => true;
    return opts;
  }

  Dio provideDio() {
    return _dio;
  }
}
