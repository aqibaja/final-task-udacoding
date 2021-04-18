// To parse this JSON data, do
//
//     final discountModel = discountModelFromJson(jsonString);

import 'dart:convert';

List<DiscountModel> discountModelFromJson(String str) =>
    List<DiscountModel>.from(
        json.decode(str).map((x) => DiscountModel.fromJson(x)));

String discountModelToJson(List<DiscountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiscountModel {
  DiscountModel({
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
    this.idUlasan,
    this.idKonsumen,
    this.rating,
    this.ulasan,
    this.waktuKirim,
    this.id,
    this.fixHarga,
  });

  dynamic idProduk;
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
  dynamic idUlasan;
  dynamic idKonsumen;
  dynamic rating;
  dynamic ulasan;
  dynamic waktuKirim;
  int id;
  int fixHarga;

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        idProduk: json["id_produk"],
        idProdukPerusahaan: json["id_produk_perusahaan"],
        idKategoriProduk: json["id_kategori_produk"],
        idKategoriProdukSub: json["id_kategori_produk_sub"],
        idReseller: json["id_reseller"],
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
        username: json["username"] == null ? null : json["username"],
        aktif: json["aktif"],
        tag: json["tag"],
        dilihat: json["dilihat"],
        minimum: json["minimum"],
        waktuInput: DateTime.parse(json["waktu_input"]),
        idProdukDiskon: json["id_produk_diskon"],
        diskon: json["diskon"],
        idUlasan: json["id_ulasan"],
        idKonsumen: json["id_konsumen"],
        rating: json["rating"],
        ulasan: json["ulasan"],
        waktuKirim: json["waktu_kirim"],
        id: json["id"],
        fixHarga: json["fix_harga"],
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "id_produk_perusahaan": idProdukPerusahaan,
        "id_kategori_produk": idKategoriProduk,
        "id_kategori_produk_sub": idKategoriProdukSub,
        "id_reseller": idReseller,
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
        "username": username == null ? null : username,
        "aktif": aktif,
        "tag": tag,
        "dilihat": dilihat,
        "minimum": minimum,
        "waktu_input": waktuInput.toIso8601String(),
        "id_produk_diskon": idProdukDiskon,
        "diskon": diskon,
        "id_ulasan": idUlasan,
        "id_konsumen": idKonsumen,
        "rating": rating,
        "ulasan": ulasan,
        "waktu_kirim": waktuKirim,
        "id": id,
        "fix_harga": fixHarga,
      };
}
