// To parse this JSON data, do
//
//     final propertyDetails = propertyDetailsFromJson(jsonString);

import 'dart:convert';

PropertyDetails propertyDetailsFromJson(String str) => PropertyDetails.fromJson(json.decode(str));

String propertyDetailsToJson(PropertyDetails data) => json.encode(data.toJson());

class PropertyDetails {
  PropertyDet property;
  List<String> images;
  List<Feature> features;

  PropertyDetails({
    required this.property,
    required this.images,
    required this.features,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) => PropertyDetails(
    property: PropertyDet.fromJson(json["property"]),
    images: List<String>.from(json["images"].map((x) => x)),
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "property": property.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class Feature {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int propertyId;
  String feature;

  Feature({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyId,
    required this.feature,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    propertyId: json["property_id"],
    feature: json["feature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "property_id": propertyId,
    "feature": feature,
  };
}

class PropertyDet {
  int userId;
  String userName;
  String propertyType;
  String status;
  String governorate;
  String address;
  String phone_number;
  int price;
  int size;
  int?floor;
  String?ownerOfTheProperty;
  String?furnished;
  String?direction;
  String?condition;
  dynamic rentalPeriod;
  int?numberOfRoom;
  String?description;
  int viewers;
  DateTime createdAt;

  PropertyDet({
    required this.userId,
    required this.userName,
    required this.propertyType,
    required this.status,
    required this.governorate,
    required this.address,
    required this.phone_number,
    required this.price,
    required this.size,
    required this.floor,
    required this.ownerOfTheProperty,
    required this.furnished,
    required this.direction,
    required this.condition,
    required this.rentalPeriod,
    required this.numberOfRoom,
    required this.description,
    required this.viewers,
    required this.createdAt,
  });

  factory PropertyDet.fromJson(Map<String, dynamic> json) => PropertyDet(
    userId: json["user_id"],
    userName: json["user_name"],
    propertyType: json["property_type"],
    status: json["status"],
    governorate: json["governorate"],
    address: json["address"],
    phone_number: json["phone_number"],
    price: json["price"],
    size: json["size"],
    floor: json["floor"],
    ownerOfTheProperty: json["owner_of_the_property"],
    furnished: json["Furnished"],
    direction: json["direction"],
    condition: json["condition"],
    rentalPeriod: json["rental_period"],
    numberOfRoom: json["numberOfRoom"],
    description: json["description"],
    viewers: json["viewers"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "property_type": propertyType,
    "status": status,
    "governorate": governorate,
    "address": address,
    "phone_number" :phone_number,
    "price": price,
    "size": size,
    "floor": floor,
    "owner_of_the_property": ownerOfTheProperty,
    "Furnished": furnished,
    "direction": direction,
    "condition": condition,
    "rental_period": rentalPeriod,
    "numberOfRoom": numberOfRoom,
    "description": description,
    "viewers": viewers,
    "created_at": createdAt.toIso8601String(),
  };
}
