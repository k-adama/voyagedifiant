class UserModel {
  int? userId;
  String? name;
  String? phone;
  String? email;
  String? token;

  UserModel({this.userId, this.name, this.phone, this.email, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];

    return UserModel(
      userId: userData['id'],
      name: userData['name'],
      phone: userData['phone'],
      email: userData['email'],
      token: json['token'], // Token est à la racine
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': userId,
        'name': name,
        'phone': phone,
        'email': email,
      },
      'token': token,
    };
  }
}
