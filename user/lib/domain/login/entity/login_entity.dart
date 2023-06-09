import 'dart:convert';

class LoginEntity {
  String id;
  String name;
  String email;
  String token;
  LoginEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  LoginEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return LoginEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'token': token});
  
    return result;
  }

  factory LoginEntity.fromMap(Map<String, dynamic> map) {
    return LoginEntity(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginEntity.fromJson(String source) => LoginEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginEntity(id: $id, name: $name, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginEntity &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      token.hashCode;
  }
}
