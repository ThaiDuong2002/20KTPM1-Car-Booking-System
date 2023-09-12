import 'package:driver/global/services/general/auth/auth_provider.dart';
import 'package:driver/global/services/general/auth/auth_user.dart';
import 'package:driver/global/services/general/auth/database_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider _provider;

  AuthService(this._provider);

  factory AuthService.initialize() => AuthService(DatabaseAuthProvider());

  @override
  AuthUser? get currentUser => _provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String identifier,
    required String password,
  }) =>
      _provider.logIn(
        identifier: identifier,
        password: password,
      );

  @override
  Future<void> logOut() => _provider.logOut();

  @override
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
  }) =>
      _provider.signUp(
        capacity,
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        avatar: avatar,
        dob: dob,
        vehicleImage: vehicleImage,
        vehicleType: vehicleType,
        vehicleColor: vehicleColor,
        licensePlate: licensePlate,
        licenseFrontImage: licenseFrontImage,
        licenseBackImage: licenseBackImage,
      );
}
