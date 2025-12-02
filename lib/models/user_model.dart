class UserModel {
  String email;
  String name;
  String uId;

  UserModel({required this.email, required this.name, required this.uId});

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'uId': uId};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'], name: json['name'], uId: json['uId']);
  }
}
