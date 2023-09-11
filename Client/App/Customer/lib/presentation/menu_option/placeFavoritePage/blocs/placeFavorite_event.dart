abstract class PlaceFavoriteEvent{

}

class PlacePressUpdate extends PlaceFavoriteEvent{
  final String name;
  final String address;
  final String description;
  final String image;
  final String id;
  PlacePressUpdate({required this.name,required this.address,required this.description,required this.image,required this.id});
}
class PlacePressFetchData extends PlaceFavoriteEvent{

}