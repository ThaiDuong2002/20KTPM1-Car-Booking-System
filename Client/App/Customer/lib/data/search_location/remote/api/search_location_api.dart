

import 'package:user/model_gobal/mylocation.dart';

import '../../../../domain/search_location/entity/item_search_entity.dart';

abstract class SearchLocationApi {
  Future<List<ItemSearchEntity>> search(String address, MyLocation currentLocation);
}
