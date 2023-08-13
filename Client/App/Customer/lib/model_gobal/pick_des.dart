import 'package:user/domain/search_location/entity/item_search_entity.dart';
import 'package:user/model_gobal/mylocation.dart';

class PickUpAndDestication {
  MyLocation? currentPosition;
  ItemSearchEntity? pickUpLocation;
  PickUpAndDestication({
    this.currentPosition,
    this.pickUpLocation,
  });

  @override
  String toString() => 'PickUpAndDestication(currentPosition: $currentPosition, pickUpLocation: $pickUpLocation)';
}
