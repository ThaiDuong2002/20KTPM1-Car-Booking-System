class VehicleModel {
  final String color;
  final String licensePlate;
  final String image;
  final String typeId;
  
  VehicleModel({
    required this.color,
    required this.licensePlate,
    required this.image,
    required this.typeId,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      color: json['color'],
      licensePlate: json['licensePlate'],
      image: json['image'],
      typeId: json['typeId'],
    );
  }
}
