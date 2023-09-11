import 'package:dio/dio.dart';
import '../../../../domain/base/base_exception.dart';
import '../../../../domain/search_location/entity/item_search_entity.dart';
import '../../../../model_gobal/mylocation.dart';
import '../dto/search_location_response.dart';
import 'search_location_api.dart';

class SearchLocationApiImple implements SearchLocationApi {
  final Dio dio;
  SearchLocationApiImple({
    required this.dio,
  });

  Future<double> calculateDistance(
      double startLat, double startLng, double endLat, double endLng) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$startLat,$startLng&destinations=$endLat,$endLng&key=AIzaSyDegGs0gQhRVn5osHdt_hOmjwiXpjpJL9Q";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      String distance =
          response.data['rows'][0]['elements'][0]['distance']['text'];
      return double.parse(distance.replaceAll(' km', ''));
    } else {
      throw Exception('Failed to calculate distance');
    }
  }

  @override
  Future<List<ItemSearchEntity>> search(
      String address, MyLocation currentLocation) async {
    try {
      final lat = currentLocation.latitude;
      final lon = currentLocation.longitude;

      final response = await dio.get(
          'https://autosuggest.search.hereapi.com/v1/autosuggest?at=$lat,$lon&limit=5&lang=en&q=$address&apiKey=hEw3XwDy1W81P-plM4aqi0guc50YBNmuKSo9uDkaYvw');

      var converted = SearchLocationResponse.fromJson(response.toString());
      final List<ItemSearchEntity> result = [];
      for (var element in converted.items!) {
        final data = ItemSearchEntity.fromMap(element);
        if(data.distance > 1000){
          data.distance  /= 1000;
          data.distance = double.parse(data.distance.toStringAsFixed(2));

          }
        result.add(data);
      }
      if (response.statusCode == 200) {
        return result;
      }
      throw BaseException(  
          message: response.statusMessage.toString(),
          code: response.statusCode);
    } on DioException catch (e) {
      throw BaseException(message: e.message!, code: e.response?.statusCode);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }
  @override
  Future<List<ItemSearchEntity>> searchCheck( MyLocation currentLocation) async {
    try {
      final lat = currentLocation.latitude;
      final lon = currentLocation.longitude;

      final response = await dio.get(
          'https://revgeocode.search.hereapi.com/v1/revgeocode?at=$lat,$lon&limit=20&apiKey=hEw3XwDy1W81P-plM4aqi0guc50YBNmuKSo9uDkaYvw');

      var converted = SearchLocationResponse.fromJson(response.toString());
      final List<ItemSearchEntity> result = [];
      for (var element in converted.items!) {
        final data = ItemSearchEntity.fromMap(element);
        if (data.distance > 1000) {
          data.distance /= 1000;
          data.distance = double.parse(data.distance.toStringAsFixed(2));
        }
        result.add(data);
      }
      if (response.statusCode == 200) {
        return result;
      }
      throw BaseException(
          message: response.statusMessage.toString(),
          code: response.statusCode);
    } on DioException catch (e) {
      throw BaseException(message: e.message!, code: e.response?.statusCode);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }
}


