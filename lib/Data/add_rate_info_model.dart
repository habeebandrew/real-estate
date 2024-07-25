// To parse this JSON data, do
//
//     final rateInfoModel = rateInfoModelFromJson(jsonString);

import 'dart:convert';

AddRateInfoModel addrateInfoModelFromJson(String str) => AddRateInfoModel.fromJson(json.decode(str));

String addrateInfoModelToJson(AddRateInfoModel data) => json.encode(data.toJson());

class AddRateInfoModel {
    String message;
    AddEvaluation evaluation;

    AddRateInfoModel({
        required this.message,
        required this.evaluation,
    });

    factory AddRateInfoModel.fromJson(Map<String, dynamic> json) => AddRateInfoModel(
        message: json["message"],
        evaluation: AddEvaluation.fromJson(json["evaluation"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "evaluation": evaluation.toJson(),
    };
}

class AddEvaluation {
    String evaluateId;
    String evaluatedId;
    String evaluation;
    String updatedAt;
    String createdAt;
    int id;

    AddEvaluation({
        required this.evaluateId,
        required this.evaluatedId,
        required this.evaluation,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AddEvaluation.fromJson(Map<String, dynamic> json) => AddEvaluation(
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
