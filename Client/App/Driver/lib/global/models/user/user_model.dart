class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? avatar;
  String? accessToken;
  String? refreshToken;

  UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.avatar,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
