import 'dart:convert';

class ItemSearchEntity {
  String name;
  String formatted_address;
  double lat;
  double lng;
  double distance;
  ItemSearchEntity({
    required this.name,
    required this.formatted_address,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'formatted_address': formatted_address});
    result.addAll({'lat': lat});
    result.addAll({'lng': lng});
    result.addAll({'distance': distance});

    return result;
  }

  factory ItemSearchEntity.fromMap(Map<String, dynamic> map) {
    return ItemSearchEntity(
      name: map['name'] ?? '',
      formatted_address: map['formatted_address'] ?? '',
      lat: map['geometry']['location']['lat']?.toDouble() ?? 0.0,
      lng: map['geometry']['location']['lng']?.toDouble() ?? 0.0,
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSearchEntity.fromJson(String source) =>
      ItemSearchEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemSearchEntity(name: $name, formatted_address: $formatted_address, lat: $lat, lng: $lng, distance: $distance)';
  }
}
