// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'dart:convert';

List<Favourite> favouriteFromJson(String str) => List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));

String favouriteToJson(List<Favourite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favourite {
  int id;
  String propertyType;
  String status;
  String governorate;
  String address;
  String createdAt;
  int size;
  int price;
  List<String> images;

  Favourite({
    required this.id,
    required this.propertyType,
    required this.status,
    required this.governorate,
    required this.address,
    required this.createdAt,
    required this.size,
    required this.price,
    required this.images,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json["id"],
    propertyType: json["propertyType"],
    status: json["status"],
    governorate: json["governorate"],
    address: json["address"],
    createdAt: json["created_at"],
    size: json["size"],
    price: json["price"],
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
    "Images": List<dynamic>.from(images.map((x) => x)),
  };
}
