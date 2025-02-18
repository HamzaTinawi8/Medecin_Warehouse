class UserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String token;

  UserModel({
    required this.id,
    required this.email,
    required this.mobile,
    required this.token, required this.name,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      mobile: json['user']['mobile'],
      token: json['token'],
    );
  }
}
