// To parse this JSON data, do
//
//     final rateInfoModel = rateInfoModelFromJson(jsonString);

import 'dart:convert';

RateInfoModel rateInfoModelFromJson(String str) => RateInfoModel.fromJson(json.decode(str));

String rateInfoModelToJson(RateInfoModel data) => json.encode(data.toJson());

class RateInfoModel {
    String message;
    Evaluation evaluation;

    RateInfoModel({
        required this.message,
        required this.evaluation,
    });

    factory RateInfoModel.fromJson(Map<String, dynamic> json) => RateInfoModel(
        message: json["message"],
        evaluation: Evaluation.fromJson(json["evaluation"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "evaluation": evaluation.toJson(),
    };
}

class Evaluation {
    int evaluateId;
    int evaluatedId;
    int evaluation;
    String updatedAt;
    String createdAt;
    int id;

    Evaluation({
        required this.evaluateId,
        required this.evaluatedId,
        required this.evaluation,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        evaluateId: json["evaluate_id"],
        evaluatedId: json["evaluated_id"],
        evaluation: json["evaluation"],
        updatedAt:json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "evaluate_id": evaluateId,
        "evaluated_id": evaluatedId,
        "evaluation": evaluation,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
    };
}
