import '../../../../model_gobal/mylocation.dart';

abstract class CheckAddressEvent {}

class CheckAddressEventSearch extends CheckAddressEvent {
  final MyLocation currentLocation;

  CheckAddressEventSearch(this.currentLocation);
}