import 'package:driver/global/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> signUp(
    int capacity, {
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
    required String avatar,
    required String dob,
    required String vehicleImage,
    required String vehicleType,
    required String vehicleColor,
    required String licensePlate,
    required String licenseFrontImage,
    required String licenseBackImage,
  });

  Future<void> logOut();

  Future<void> initialize();
}
