import 'package:dio/dio.dart';

import '../interceptor/authorization_interceptor.dart';

import '../interceptor/logger_interceptor.dart';
import 'endpoints.dart';
class NetworkModule {
   final Dio _dio =  Dio();
   final RequestInterceptor requestInterceptor;
   final LoggerInterceptor lggerInterceptor = LoggerInterceptor();

   NetworkModule({required this.requestInterceptor});
    BaseOptions _dioOptions() {
      BaseOptions opts = BaseOptions();
      opts.baseUrl = Endpoints.baseURL;
      opts.connectTimeout = Endpoints.connectionTimeout;
      opts.receiveTimeout = Endpoints.receiveTimeout;
      return opts;
    }

    Dio provideDio() {
      _dio.options = _dioOptions();
      _dio.interceptors.add(requestInterceptor);
      _dio.interceptors.add(lggerInterceptor);
      return _dio;
    }

}
