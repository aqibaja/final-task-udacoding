// To parse this JSON data, do
//
//     final konsumenFailModel = konsumenFailModelFromJson(jsonString);

import 'dart:convert';

KonsumenFailModel konsumenFailModelFromJson(String str) =>
    KonsumenFailModel.fromJson(json.decode(str));

String konsumenFailModelToJson(KonsumenFailModel data) =>
    json.encode(data.toJson());

class KonsumenFailModel {
  KonsumenFailModel({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory KonsumenFailModel.fromJson(Map<String, dynamic> json) =>
      KonsumenFailModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
