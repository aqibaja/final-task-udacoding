// To parse this JSON data, do
//
//     final provinsiModel = provinsiModelFromJson(jsonString);

import 'dart:convert';

List<ProvinsiModel> provinsiModelFromJson(String str) =>
    List<ProvinsiModel>.from(
        json.decode(str).map((x) => ProvinsiModel.fromJson(x)));

String provinsiModelToJson(List<ProvinsiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinsiModel {
  ProvinsiModel({
    this.provinceId,
    this.provinceName,
  });

  int provinceId;
  String provinceName;

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) => ProvinsiModel(
        provinceId: json["province_id"],
        provinceName: json["province_name"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
      };
}
