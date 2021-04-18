// To parse this JSON data, do
//
//     final addDeleteCartModel = addDeleteCartModelFromJson(jsonString);

import 'dart:convert';

AddDeleteCartModel addDeleteCartModelFromJson(String str) =>
    AddDeleteCartModel.fromJson(json.decode(str));

String addDeleteCartModelToJson(AddDeleteCartModel data) =>
    json.encode(data.toJson());

class AddDeleteCartModel {
  AddDeleteCartModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  String data;

  factory AddDeleteCartModel.fromJson(Map<String, dynamic> json) =>
      AddDeleteCartModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
