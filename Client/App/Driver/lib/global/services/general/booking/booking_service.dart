import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:driver/global/endpoints/booking_endpoint.dart';
import 'package:driver/global/interceptors/auth_interceptor.dart';
import 'package:driver/global/models/booking/booking_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';

class BookingService {
  final Dio _dio = Dio();

  Future<List<BookingModel>> getBookingListByDriver(String id) async {
    _dio.interceptors.add(AuthInterceptor(_dio));
    try {
      final bookingFetchingList = await _dio.get('$bookingListOfDriverEndpoint/$id');
      if (bookingFetchingList.statusCode == 200) {
        final bookingJsonList = jsonDecode(bookingFetchingList.toString());
        final bookingListData = bookingJsonList['data'];
        return bookingListData.map<BookingModel>((item) {
          final pickupLocation = item['pickupLocation'];
          final destinationLocation = item['destinationLocation'];
          return BookingModel(
            item['userId'],
            item['driverId'],
            item['customerName'],
            item['customerPhone'],
            item['type'],
            pickupLocation['address'],
            destinationLocation['address'],
            item['pickupTime'],
            item['dropOffTime'],
            item['createdAt'],
            item['paymentMethodId'],
            item['promotionId'],
            item['status'],
            item['total'],
            item['distance'],
          );
        }).toList();
      } else {
        throw UnknowFetchingDataException();
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
