import 'package:user/data/search_location/remote/api/search_location_api.dart';
import 'package:user/domain/search_location/entity/item_search_entity.dart';

import '../../../domain/base/base_exception.dart';
import '../../../domain/base/base_failure.dart';
import '../../../domain/base/base_result.dart';
import '../../../model_gobal/mylocation.dart';

class SearchLocationRepository {
  final SearchLocationApi searchLocationApi;

  SearchLocationRepository({ required this.searchLocationApi });

  Future<BaseResult<List<ItemSearchEntity>, Failure>> search(
      String address, MyLocation currentLocation) async {
    try {
      var result = await searchLocationApi.search(address, currentLocation);
      return BaseResult.success(result);
    } on BaseException catch (e) {
      return BaseResult.error(BaseFailure(message: e.message, code: e.code!));
    }
  }
  Future<BaseResult<List<ItemSearchEntity>, Failure>> searchCheck( MyLocation currentLocation) async {
    try {
      var result = await searchLocationApi.searchCheck(currentLocation);
      return BaseResult.success(result);
    } on BaseException catch (e) {
      return BaseResult.error(BaseFailure(message: e.message, code: e.code!));
    }
  }
}
