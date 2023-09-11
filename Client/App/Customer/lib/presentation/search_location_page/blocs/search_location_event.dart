import 'package:user/model_gobal/mylocation.dart';

import '../../../domain/search_location/entity/item_search_entity.dart';

abstract class SearchLocationEvent {}

class SearchLocationEventSearch extends SearchLocationEvent {
  final String query;
  final MyLocation searchLocation;

  SearchLocationEventSearch(this.query, this.searchLocation);
}
class SearchLocationEventSearchChoose extends SearchLocationEvent{
  
}
class SearchLocationEventSearchAddList extends SearchLocationEvent {
  final String type;
  ItemSearchEntity item;
  SearchLocationEventSearchAddList({
    required this.item,
    required this.type,
  });
}


