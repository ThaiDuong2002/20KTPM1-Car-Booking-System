import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/payment_method_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/payment.method/payment_method_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';

class PaymentMethodService {
  final Dio _dio = Dio();

  Future<PaymentMethodModel> getPaymentMethod(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.get('$getPaymentEndpoint/$id');
      if (response.statusCode == 200) {
        final paymentJsonData = jsonDecode(response.toString());
        final paymentData = paymentJsonData['data'];
        return PaymentMethodModel.fromJson(paymentData);
      }
      throw UnknowFetchingDataException();
    } catch (e) {
      return Future.error(e);
    }
  }
}
