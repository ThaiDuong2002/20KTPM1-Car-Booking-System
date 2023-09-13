import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/vehicle_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/vehicle/vehicle_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';

class VehicleService {
  final Dio _dio = Dio();

  Future<VehicleModel> getVehicle(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final response = await _dio.get('$vehicleDetailEndpoint/$id');
      if (response.statusCode == 200) {
        final vehicleJsonData = jsonDecode(response.toString());
        final data = vehicleJsonData['data'];
        return VehicleModel.fromJson(data);
      } else {
        throw UnknowFetchingDataException();
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
