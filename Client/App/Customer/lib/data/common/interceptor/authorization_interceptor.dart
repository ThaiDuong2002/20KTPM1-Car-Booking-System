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
            {options.headers["Authorization"] = value['accessToken'].toString()}
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
