import 'dart:convert';

class LoginRequest {
  String identifier;
  String password;
  LoginRequest({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'identifier': identifier});
    result.addAll({'password': password});

    return result;
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      identifier: map['identifier'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginRequest(indentifier: $identifier, password: $password)';
}
