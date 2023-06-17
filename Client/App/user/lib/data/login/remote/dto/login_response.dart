import 'dart:convert';
class LoginResponse  {
  String? id;
  String? name;
  String? email;
  String? token;
  LoginResponse({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  

  LoginResponse copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return LoginResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(token != null){
      result.addAll({'token': token});
    }
  
    return result;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );
  }


  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginResponse(id: $id, name: $name, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginResponse &&
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
