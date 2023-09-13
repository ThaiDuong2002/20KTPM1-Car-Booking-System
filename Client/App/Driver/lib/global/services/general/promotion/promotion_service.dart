import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/promotion_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/promotion/promotion_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';

class PromotionService {
  final Dio _dio = Dio();

  Future<PromotionModel> getPromotion(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.get('$promotionEndpoint/$id');
      if (response.statusCode == 200) {
        final promotionJsonData = jsonDecode(response.toString());
        final promotionData = promotionJsonData['data'];
        return PromotionModel.fromJson(promotionData);
      }
      throw UnknowFetchingDataException();
    } catch (e) {
      throw Future.error(e);
    }
  }
}
