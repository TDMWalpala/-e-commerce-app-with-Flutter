import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  // final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.address,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      // 'address': address,
      'type': type,
      'token': token,
    };
  }

    factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'].toString(),
      email: map['email'].toString(),
      password: map['password'].toString(),
      token: map['token'].toString(),
      type: map['type'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
