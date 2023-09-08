import 'package:driver/global/services/auth/auth_provider.dart';
import 'package:driver/global/services/auth/auth_user.dart';
import 'package:driver/global/services/auth/database_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider _provider;

  AuthService(this._provider);

  factory AuthService.initialize() => AuthService(DatabaseAuthProvider());

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

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
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
