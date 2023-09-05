import 'dart:convert';

class ItemSearchEntity {
  String label;
  String title;
  double lat;
  double lng;
  double distance;
  ItemSearchEntity({
    required this.label,
    required this.title,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'label': label});
    result.addAll({'title': title});
    result.addAll({'lat': lat});
    result.addAll({'lng': lng});
    result.addAll({'distance': distance});

    return result;
  }

  factory ItemSearchEntity.fromMap(Map<String, dynamic> map) {
    return ItemSearchEntity(
      label: map['address']['label'] ?? '',
      title: map['title'] ?? '',
      lat: map['position']['lat']?.toDouble() ?? 0.0,
      lng: map['position']['lng']?.toDouble() ?? 0.0,
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSearchEntity.fromJson(String source) =>
      ItemSearchEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemSearchEntity(label: $label, title: $title, lat: $lat, lng: $lng, distance: $distance)';
  }
}
