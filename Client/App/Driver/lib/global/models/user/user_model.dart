class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String avatar;
  final List<String> driverLicense;
  final String vehicleId;
  final bool isActive;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.driverLicense,
    required this.vehicleId,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      driverLicense: json['driverLicense'].cast<String>(),
      vehicleId: json['vehicleId'],
      isActive: json['isActive'],
    );
  }
}
