// To parse this JSON data, do
//
//     final geSubModel = geSubModelFromJson(jsonString);

import 'dart:convert';

GeSubModel geSubModelFromJson(String str) => GeSubModel.fromJson(json.decode(str));

String geSubModelToJson(GeSubModel data) => json.encode(data.toJson());

class GeSubModel {
    String startDate;
    String endDate;
    String daysRemaining;
   

    GeSubModel({
        required this.startDate,
        required this.endDate,
        required this.daysRemaining,

    });

    factory GeSubModel.fromJson(Map<String, dynamic> json) => GeSubModel(
        startDate:json["startDate"],
        endDate: json["endDate"],
        daysRemaining: json["daysRemaining"],

    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "daysRemaining": daysRemaining,

    };
}
