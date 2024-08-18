// To parse this JSON data, do
//
//     final addSubscribeModel = addSubscribeModelFromJson(jsonString);

import 'dart:convert';

AddSubscribeModel addSubscribeModelFromJson(String str) => AddSubscribeModel.fromJson(json.decode(str));

String addSubscribeModelToJson(AddSubscribeModel data) => json.encode(data.toJson());

class AddSubscribeModel {
    String message;
    int roleId;

    AddSubscribeModel({
        required this.message,
        required this.roleId,
    });

    factory AddSubscribeModel.fromJson(Map<String, dynamic> json) => AddSubscribeModel(
        message: json["message"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "role_id": roleId,
    };
}
