// To parse this JSON data, do
//
//     final listFavoriteModel = listFavoriteModelFromJson(jsonString);

import 'dart:convert';

List<ListFavoriteModel> listFavoriteModelFromJson(String str) =>
    List<ListFavoriteModel>.from(
        json.decode(str).map((x) => ListFavoriteModel.fromJson(x)));

String listFavoriteModelToJson(List<ListFavoriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListFavoriteModel {
  ListFavoriteModel({
    this.idProduk,
    this.idProdukPerusahaan,
    this.idKategoriProduk,
    this.idKategoriProdukSub,
    this.idReseller,
    this.namaProduk,
    this.produkSeo,
    this.satuan,
    this.hargaBeli,
    this.hargaReseller,
    this.hargaKonsumen,
    this.berat,
    this.gambar,
    this.tentangProduk,
    this.keterangan,
    this.username,
    this.aktif,
    this.tag,
    this.dilihat,
    this.minimum,
    this.waktuInput,
    this.idProdukDiskon,
    this.diskon,
    this.idKonsumenSimpan,
    this.idKonsumen,
    this.waktuSimpan,
    this.id,
    this.fixHarga,
  });

  int idProduk;
  int idProdukPerusahaan;
  int idKategoriProduk;
  int idKategoriProdukSub;
  int idReseller;
  String namaProduk;
  String produkSeo;
  String satuan;
  int hargaBeli;
  int hargaReseller;
  int hargaKonsumen;
  String berat;
  String gambar;
  String tentangProduk;
  String keterangan;
  String username;
  String aktif;
  String tag;
  int dilihat;
  int minimum;
  DateTime waktuInput;
  int idProdukDiskon;
  int diskon;
  int idKonsumenSimpan;
  int idKonsumen;
  DateTime waktuSimpan;
  int id;
  int fixHarga;

  factory ListFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ListFavoriteModel(
        idProduk: json["id_produk"],
        idProdukPerusahaan: json["id_produk_perusahaan"],
        idKategoriProduk: json["id_kategori_produk"],
        idKategoriProdukSub: json["id_kategori_produk_sub"],
        idReseller: json["id_reseller"] == null ? null : json["id_reseller"],
        namaProduk: json["nama_produk"],
        produkSeo: json["produk_seo"],
        satuan: json["satuan"],
        hargaBeli: json["harga_beli"],
        hargaReseller: json["harga_reseller"],
        hargaKonsumen: json["harga_konsumen"],
        berat: json["berat"],
        gambar: json["gambar"],
        tentangProduk: json["tentang_produk"],
        keterangan: json["keterangan"],
        username: json["username"],
        aktif: json["aktif"],
        tag: json["tag"],
        dilihat: json["dilihat"],
        minimum: json["minimum"],
        waktuInput: DateTime.parse(json["waktu_input"]),
        idProdukDiskon:
            json["id_produk_diskon"] == null ? null : json["id_produk_diskon"],
        diskon: json["diskon"] == null ? null : json["diskon"],
        idKonsumenSimpan: json["id_konsumen_simpan"],
        idKonsumen: json["id_konsumen"],
        waktuSimpan: DateTime.parse(json["waktu_simpan"]),
        id: json["id"],
        fixHarga: json["fix_harga"] == null ? null : json["fix_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_produk_perusahaan": idProdukPerusahaan,
        "id_kategori_produk": idKategoriProduk,
        "id_kategori_produk_sub": idKategoriProdukSub,
        "id_reseller": idReseller == null ? null : idReseller,
        "nama_produk": namaProduk,
        "produk_seo": produkSeo,
        "satuan": satuan,
        "harga_beli": hargaBeli,
        "harga_reseller": hargaReseller,
        "harga_konsumen": hargaKonsumen,
        "berat": berat,
        "gambar": gambar,
        "tentang_produk": tentangProduk,
        "keterangan": keterangan,
        "username": username,
        "aktif": aktif,
        "tag": tag,
        "dilihat": dilihat,
        "minimum": minimum,
        "waktu_input": waktuInput.toIso8601String(),
        "id_produk_diskon": idProdukDiskon == null ? null : idProdukDiskon,
        "diskon": diskon == null ? null : diskon,
        "id_konsumen_simpan": idKonsumenSimpan,
        "id_konsumen": idKonsumen,
        "waktu_simpan": waktuSimpan.toIso8601String(),
        "id": id,
        "fix_harga": fixHarga == null ? null : fixHarga,
      };
}
