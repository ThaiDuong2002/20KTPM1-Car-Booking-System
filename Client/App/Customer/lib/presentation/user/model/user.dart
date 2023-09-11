import 'dart:convert';

class User {
  String firstname;
  String lastname;
  String email;
  String phone;
  String avatar;
  String userRole;
  List<dynamic> address;
  String userType;
  bool isDisabled;
  String createdAt;
  String updatedAt;
  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.userRole,
    required this.address,
    required this.userType,
    required this.isDisabled,
    required this.createdAt,
    required this.updatedAt,
  });




  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'firstname': firstname});
    result.addAll({'lastname': lastname});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'avatar': avatar});
    result.addAll({'userRole': userRole});
    result.addAll({'address': address});
    result.addAll({'userType': userType});
    result.addAll({'isDisabled': isDisabled});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      avatar: map['avatar'] ?? '',
      userRole: map['userRole'] ?? '',
      address: List<dynamic>.from(map['address']),
      userType: map['userType'] ?? '',
      isDisabled: map['isDisabled'] ?? false,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
