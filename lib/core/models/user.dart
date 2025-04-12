class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? token;

  UserModel({this.id, this.name, this.phone, this.email, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];

    return UserModel(
      id: userData['id'],
      name: userData['name'],
      phone: userData['phone'],
      email: userData['email'],
      token: json['token'], // Token est à la racine
    );
  }
}
