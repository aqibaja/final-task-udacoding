// To parse this JSON data, do
//
//     final myShopModel = myShopModelFromJson(jsonString);

import 'dart:convert';

MyShopModel myShopModelFromJson(String str) =>
    MyShopModel.fromJson(json.decode(str));

String myShopModelToJson(MyShopModel data) => json.encode(data.toJson());

class MyShopModel {
  MyShopModel({
    this.success,
    this.message,
  });

  String success;
  String message;

  factory MyShopModel.fromJson(Map<String, dynamic> json) => MyShopModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
