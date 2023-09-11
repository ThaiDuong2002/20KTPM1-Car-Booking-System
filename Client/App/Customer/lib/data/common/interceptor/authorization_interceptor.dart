import 'package:dio/dio.dart';
import '../module/shared_pref_module.dart';

class RequestInterceptor extends Interceptor {
  static SharedPreferenceModule? _pref;
  static final RequestInterceptor _singleton = RequestInterceptor._internal();

  factory RequestInterceptor() {
    return _singleton;
  }
  RequestInterceptor._internal();

  static set pref(SharedPreferenceModule value) => _pref = value;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _pref?.getUserInfo().then((value) => {
          if (value.isNotEmpty)
            {
              options.headers["Authorization"] = "Bearer " +
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NGYyMzVlZmExYTkyNTM1NDU1MTllMTIiLCJ1c2VyVHlwZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjk0MzUzMjAxLCJleHAiOjE2OTQzNTM4MDF9.3iwutkO95yzRSFcET4NjW8UfU8Yn3G7G8uQRsV3pHuI",
              print(value['accessToken'].toString())
            }
        });

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("=== Dio Error Occured ===");
    print(err.message);
    return super.onError(err, handler);
  }
}
