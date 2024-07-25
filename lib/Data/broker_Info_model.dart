// To parse this JSON data, do
//
//     final brokerInfoModel = brokerInfoModelFromJson(jsonString);

import 'dart:convert';

BrokerInfoModel brokerInfoModelFromJson(String str) => BrokerInfoModel.fromJson(json.decode(str));

String brokerInfoModelToJson(BrokerInfoModel data) => json.encode(data.toJson());

class BrokerInfoModel {
    String?phoneNumber;
    String imageUrl;
    int evaluate;

    BrokerInfoModel({
        required this.phoneNumber,
        required this.imageUrl,
        required this.evaluate,
    });

    factory BrokerInfoModel.fromJson(Map<String, dynamic> json) => BrokerInfoModel(
        phoneNumber: json["phone_number"],
        imageUrl: json["image_URL"],
        evaluate: json["evaluate"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "image_URL": imageUrl,
        "evaluate": evaluate,
    };
}
