// To parse this JSON data, do
//
//     final addDeleteFavoriteModel = addDeleteFavoriteModelFromJson(jsonString);

import 'dart:convert';

AddDeleteFavoriteModel addDeleteFavoriteModelFromJson(String str) =>
    AddDeleteFavoriteModel.fromJson(json.decode(str));

String addDeleteFavoriteModelToJson(AddDeleteFavoriteModel data) =>
    json.encode(data.toJson());

class AddDeleteFavoriteModel {
  AddDeleteFavoriteModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  String data;

  factory AddDeleteFavoriteModel.fromJson(Map<String, dynamic> json) =>
      AddDeleteFavoriteModel(
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
