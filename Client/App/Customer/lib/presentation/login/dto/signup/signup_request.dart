import 'dart:convert';

class SignUpRequest {
  String firstname;
  String lastname;
  String phone;
  String email;
  String password;
  SignUpRequest({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'SignUpRequest(firtname: $firstname, lastname: $lastname, phone: $phone, email: $email, password: $password)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'firstname': firstname});
    result.addAll({'lastname': lastname});
    result.addAll({'phone': phone});
    result.addAll({'email': email});
    result.addAll({'password': password});
  
    return result;
  }

  factory SignUpRequest.fromMap(Map<String, dynamic> map) {
    return SignUpRequest(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequest.fromJson(String source) => SignUpRequest.fromMap(json.decode(source));
}
