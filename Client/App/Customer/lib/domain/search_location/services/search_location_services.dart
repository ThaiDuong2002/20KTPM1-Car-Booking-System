
import 'package:user/data/search_location/respository/search_location_repository.dart';
import 'package:user/domain/search_location/entity/item_search_entity.dart';

import '../../../model_gobal/mylocation.dart';
import '../../base/base_failure.dart';
import '../../base/base_result.dart';

class SearchLocationServices {
  final SearchLocationRepository loginRepository;

  SearchLocationServices({required this.loginRepository});

  Future<BaseResult<List<ItemSearchEntity>, Failure>> search(
     String address, MyLocation currentLocation) async {
    return await loginRepository.search(address, currentLocation);
  }
}
