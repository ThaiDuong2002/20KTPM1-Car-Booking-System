import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final String id;
  final String email;
  final String phone;
  final String avatar;
  final String firstname;
  final String lastname;

  const AuthUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.firstname,
    required this.lastname,
  });

  factory AuthUser.fromDatabase(Map<String, dynamic> user) => AuthUser(
    id: user['_id'],
    email: user['email'],
    phone: user['phone'],
    avatar: user['avatar'],
    firstname: user['firstname'],
    lastname: user['lastname'],
  );
}
