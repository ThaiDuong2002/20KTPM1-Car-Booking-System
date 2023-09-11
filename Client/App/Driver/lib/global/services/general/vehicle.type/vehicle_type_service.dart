import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/vehicle_type_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/vehicle/vehicle_type_model.dart';

class VehicleTypeService {
  final Dio _dio = Dio();

  Future<VehicleTypeModel> getVehicleType(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final vehicleType = await _dio.get(
        '$getVehicleTypeUrl/$id',
      );
      if (vehicleType.statusCode == 200) {
        final rs = jsonDecode(vehicleType.toString());
        final data = rs['data'];
        return VehicleTypeModel.fromJson(data);
      }
      return Future.error(vehicleType.statusMessage ?? 'Error');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<VehicleTypeModel>> getlistVehicleType() async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final vehicleType = await _dio.get(getVehicleListUrl);
      if (vehicleType.statusCode == 200) {
        final rs = jsonDecode(vehicleType.toString());
        final data = rs['data'];
        return data.map<VehicleTypeModel>((item) => VehicleTypeModel.fromJson(item)).toList();
      }
      return Future.error(vehicleType.statusMessage ?? 'Error');
    } catch (e) {
      return Future.error(e);
    }
  }
}
