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
      final response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$address&key=AIzaSyDegGs0gQhRVn5osHdt_hOmjwiXpjpJL9Q');

      var converted = SearchLocationResponse.fromJson(response.toString());
      final List<ItemSearchEntity> result = [];
      for (var element in converted.results!) {
        final data = ItemSearchEntity.fromMap(element);
        double distance = await calculateDistance(currentLocation.latitude!,
            currentLocation.longitude!, data.lat, data.lng);
        data.distance = distance;
        print(data);
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
