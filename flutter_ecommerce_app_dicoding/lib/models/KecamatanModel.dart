// To parse this JSON data, do
//
//     final kecamatanModel = kecamatanModelFromJson(jsonString);

import 'dart:convert';

List<KecamatanModel> kecamatanModelFromJson(String str) =>
    List<KecamatanModel>.from(
        json.decode(str).map((x) => KecamatanModel.fromJson(x)));

String kecamatanModelToJson(List<KecamatanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KecamatanModel {
  KecamatanModel({
    this.subdistrictId,
    this.cityId,
    this.subdistrictName,
  });

  int subdistrictId;
  int cityId;
  String subdistrictName;

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
        subdistrictId: json["subdistrict_id"],
        cityId: json["city_id"],
        subdistrictName: json["subdistrict_name"],
      );

  Map<String, dynamic> toJson() => {
        "subdistrict_id": subdistrictId,
        "city_id": cityId,
        "subdistrict_name": subdistrictName,
      };
}
