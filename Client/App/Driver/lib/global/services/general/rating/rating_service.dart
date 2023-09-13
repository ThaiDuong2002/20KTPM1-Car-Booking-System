import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/rating_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/rating/rating_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';
import 'package:flutter/material.dart';

class RatingService {
  final Dio _dio = Dio();

  Future<List<RatingModel>> getRatingByDriverId(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.get('$driverRatingEndpoint/$id');
      debugPrint('testing $response');
      if (response.statusCode == 200) {
        final ratingJsonData = jsonDecode(response.toString());
        final ratingData = ratingJsonData['data'];
        return List<RatingModel>.from(
          ratingData.map((e) => RatingModel.fromJson(e)),
        );
      }
      throw UnknowFetchingDataException();
    } catch (e) {
      return Future.error(e);
    }
  }
}
