

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  UserClass user;
  String accessToken;

  User({
    required this.user,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    user: UserClass.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class UserClass {
  int roleId;
  String firstName;
  String lastName;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  UserClass({
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    roleId: json["role_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
