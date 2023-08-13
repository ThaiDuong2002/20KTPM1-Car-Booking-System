import 'dart:convert';

class DistanceLocation {
  double? distance;
  double? minute;
  DistanceLocation({
    this.distance,
    this.minute,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(distance != null){
      result.addAll({'distance': distance});
    }
    if(minute != null){
      result.addAll({'minute': minute});
    }
  
    return result;
  }

  factory DistanceLocation.fromMap(Map<String, dynamic> map) {
    return DistanceLocation(
      distance: map['distance']?.toDouble(),
      minute: map['minute']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceLocation.fromJson(String source) => DistanceLocation.fromMap(json.decode(source));
}
