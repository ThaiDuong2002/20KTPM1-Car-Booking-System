import 'package:driver/global/models/user/user_model.dart';

class AuthUser {
  final String id;
  final String email;
  final String phone;
  final bool isVerified;

  const AuthUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.isVerified,
  });

  factory AuthUser.fromDatabase(UserModel user) => AuthUser(
        id: user.id!,
        email: user.email!,
        phone: user.phone!,
        isVerified: user.isVerified!,
      );
}
