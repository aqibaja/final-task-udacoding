// To parse this JSON data, do
//
//     final editKonsumenModel = editKonsumenModelFromJson(jsonString);

import 'dart:convert';

EditKonsumenModel editKonsumenModelFromJson(String str) =>
    EditKonsumenModel.fromJson(json.decode(str));

String editKonsumenModelToJson(EditKonsumenModel data) =>
    json.encode(data.toJson());

class EditKonsumenModel {
  EditKonsumenModel({
    this.success,
    this.message,
  });

  String success;
  String message;

  factory EditKonsumenModel.fromJson(Map<String, dynamic> json) =>
      EditKonsumenModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
