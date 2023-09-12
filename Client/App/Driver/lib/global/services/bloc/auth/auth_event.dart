class AuthEvent {
  const AuthEvent();
}

class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String identifier;
  final String password;

  const AuthLoginEvent({
    required this.identifier,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  String email;
  String password;
  String firstname;
  String lastname;
  String phone;
  String avatar;
  String dob;
  String vehicleImage;
  String vehicleType;
  String vehicleColor;
  String licensePlate;
  String licenseFrontImage;
  String licenseBackImage;

  AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.avatar,
    required this.dob,
    required this.vehicleImage,
    required this.vehicleType,
    required this.vehicleColor,
    required this.licensePlate,
    required this.licenseFrontImage,
    required this.licenseBackImage,
  });
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}
