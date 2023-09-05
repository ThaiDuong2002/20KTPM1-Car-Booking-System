class MyLocation {
   double? latitude;
   double? longitude;
   String? name;
  final String? format_address;
  MyLocation({
    this.latitude,
    this.longitude,
    this.name,
    this.format_address,
  });

  

  @override
  String toString() {
    return 'MyLocation(latitude: $latitude, longitude: $longitude, name: $name, format_address: $format_address)';
  }

  MyLocation copyWith({
    double? latitude,
    double? longitude,
    String? name,
    String? format_address,
  }) {
    return MyLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      format_address: format_address ?? this.format_address,
    );
  }
}
