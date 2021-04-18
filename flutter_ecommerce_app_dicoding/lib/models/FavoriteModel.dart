// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteModel> favoriteModelFromJson(String str) =>
    List<FavoriteModel>.from(
        json.decode(str).map((x) => FavoriteModel.fromJson(x)));

String favoriteModelToJson(List<FavoriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
  FavoriteModel({
    this.idKonsumenSimpan,
    this.idKonsumen,
    this.idProduk,
    this.waktuSimpan,
  });

  int idKonsumenSimpan;
  int idKonsumen;
  int idProduk;
  DateTime waktuSimpan;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        idKonsumenSimpan: json["id_konsumen_simpan"],
        idKonsumen: json["id_konsumen"],
        idProduk: json["id_produk"],
        waktuSimpan: DateTime.parse(json["waktu_simpan"]),
      );

  Map<String, dynamic> toJson() => {
        "id_konsumen_simpan": idKonsumenSimpan,
        "id_konsumen": idKonsumen,
        "id_produk": idProduk,
        "waktu_simpan": waktuSimpan.toIso8601String(),
      };
}
