// To parse this JSON data, do
//
//     final listZonkFavoriteModel = listZonkFavoriteModelFromJson(jsonString);

import 'dart:convert';

ListZonkFavoriteModel listZonkFavoriteModelFromJson(String str) =>
    ListZonkFavoriteModel.fromJson(json.decode(str));

String listZonkFavoriteModelToJson(ListZonkFavoriteModel data) =>
    json.encode(data.toJson());

class ListZonkFavoriteModel {
  ListZonkFavoriteModel({
    this.success,
    this.message,
  });

  String success;
  String message;

  factory ListZonkFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ListZonkFavoriteModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
