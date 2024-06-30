// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

List<Property> propertyFromJson(String str) => List<Property>.from(json.decode(str).map((x) => Property.fromJson(x)));

String propertyToJson(List<Property> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Property {
  int id;
  String propertyType;
  String status;
  String governorate;
  String address;
  String createdAt;
  int size;
  int price;
  int viewers;
  bool existingFavorite;
  List<String> images;

  Property({
    required this.id,
    required this.propertyType,
    required this.status,
    required this.governorate,
    required this.address,
    required this.createdAt,
    required this.size,
    required this.price,
    required this.viewers,
    required this.existingFavorite,
    required this.images,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"],
    propertyType: json["propertyType"],
    status: json["status"],
    governorate: json["governorate"],
    address: json["address"],
    createdAt: json["created_at"],
    size: json["size"],
    price: json["price"],
    viewers: json["viewers"],
    existingFavorite: json["existing Favorite"],
    images: List<String>.from(json["Images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "propertyType": propertyType,
    "status": status,
    "governorate": governorate,
    "address": address,
    "created_at": createdAt,
    "size": size,
    "price": price,
    "viewers": viewers,
    "existing Favorite": existingFavorite,
    "Images": List<dynamic>.from(images.map((x) => x)),
  };
}
