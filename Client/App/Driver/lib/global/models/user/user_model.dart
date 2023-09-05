class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? password;
  String? avatar;
  String? token;
  bool? isVerified;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.avatar,
    this.token,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      avatar: json['avatar'],
      token: json['token'],
      isVerified: json['isVerified'],
    );
  }
}
