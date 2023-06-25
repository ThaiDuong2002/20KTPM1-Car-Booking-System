import 'dart:convert';

import 'package:dio/dio.dart';

import '../module/shared_pref_module.dart';

class RequestInterceptor extends Interceptor {
  final SharedPreferenceModule pref;

  RequestInterceptor({required this.pref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    pref.getUserInfo().then((value) => {
          if (value.isNotEmpty)
            {options.headers["Authorization"] = value['token'].toString()}
        });

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("=== Dio Error Occured ===");
    print(err.message);
    // consider to remap this error to generic error.
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}
