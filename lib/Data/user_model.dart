

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  UserClass user;
  String accessToken;
  String image;
  String? number;


  User({
    required this.user,
    required this.accessToken,
    required this.image,
    required this.number,

  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    user: UserClass.fromJson(json["user"]),
    accessToken: json["access_token"],
    image: json["image"],
    number: json["number"],


  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
    "image": image,
    "number": number,

  };
}

class UserClass {
  int roleId;
  String username;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  UserClass({
    required this.roleId,
    required this.username,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    roleId: json["role_id"],
    username: json["user_name"],
    email: json["email"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "user_name": username,
    "email": email,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
