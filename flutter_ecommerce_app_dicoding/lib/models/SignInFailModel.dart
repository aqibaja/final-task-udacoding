// To parse this JSON data, do
//
//     final signInFailModel = signInFailModelFromJson(jsonString);

import 'dart:convert';

SignInFailModel signInFailModelFromJson(String str) =>
    SignInFailModel.fromJson(json.decode(str));

String signInFailModelToJson(SignInFailModel data) =>
    json.encode(data.toJson());

class SignInFailModel {
  SignInFailModel({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory SignInFailModel.fromJson(Map<String, dynamic> json) =>
      SignInFailModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
