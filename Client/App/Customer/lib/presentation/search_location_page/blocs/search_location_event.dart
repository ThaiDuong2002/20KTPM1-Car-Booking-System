import 'package:user/model_gobal/mylocation.dart';

abstract class SearchLocationEvent {}

class SearchLocationEventSearch extends SearchLocationEvent {
  final String query;
  final MyLocation searchLocation;

  SearchLocationEventSearch(this.query, this.searchLocation);
}
class SearchLocationEventSearchChoose extends SearchLocationEvent{
  
}