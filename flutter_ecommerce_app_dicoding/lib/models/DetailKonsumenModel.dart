// To parse this JSON data, do
//
//     final detailKonsumenModel = detailKonsumenModelFromJson(jsonString);

import 'dart:convert';

DetailKonsumenModel detailKonsumenModelFromJson(String str) =>
    DetailKonsumenModel.fromJson(json.decode(str));

String detailKonsumenModelToJson(DetailKonsumenModel data) =>
    json.encode(data.toJson());

class DetailKonsumenModel {
  DetailKonsumenModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  Data data;

  factory DetailKonsumenModel.fromJson(Map<String, dynamic> json) =>
      DetailKonsumenModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.idKonsumen,
    this.username,
    this.password,
    this.namaLengkap,
    this.email,
    this.jenisKelamin,
    this.tanggalLahir,
    this.tempatLahir,
    this.alamatLengkap,
    this.kecamatanId,
    this.kotaId,
    this.provinsiId,
    this.noHp,
    this.foto,
    this.tanggalDaftar,
    this.token,
    this.referralId,
    this.provinceId,
    this.provinceName,
    this.cityId,
    this.cityName,
    this.postalCode,
    this.subdistrictId,
    this.subdistrictName,
  });

  int idKonsumen;
  String username;
  String password;
  String namaLengkap;
  String email;
  String jenisKelamin;
  String tanggalLahir;
  String tempatLahir;
  String alamatLengkap;
  int kecamatanId;
  int kotaId;
  int provinsiId;
  dynamic noHp;
  String foto;
  String tanggalDaftar;
  String token;
  dynamic referralId;
  dynamic provinceId;
  dynamic provinceName;
  dynamic cityId;
  dynamic cityName;
  dynamic postalCode;
  dynamic subdistrictId;
  dynamic subdistrictName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idKonsumen: json["id_konsumen"],
        username: json["username"],
        password: json["password"],
        namaLengkap: json["nama_lengkap"],
        email: json["email"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalLahir: json["tanggal_lahir"],
        tempatLahir: json["tempat_lahir"],
        alamatLengkap: json["alamat_lengkap"],
        kecamatanId: json["kecamatan_id"],
        kotaId: json["kota_id"],
        provinsiId: json["provinsi_id"],
        noHp: json["no_hp"],
        foto: json["foto"],
        tanggalDaftar: json["tanggal_daftar"],
        token: json["token"],
        referralId: json["referral_id"],
        provinceId: json["province_id"],
        provinceName: json["province_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
        subdistrictId: json["subdistrict_id"],
        subdistrictName: json["subdistrict_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_konsumen": idKonsumen,
        "username": username,
        "password": password,
        "nama_lengkap": namaLengkap,
        "email": email,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": tanggalLahir,
        "tempat_lahir": tempatLahir,
        "alamat_lengkap": alamatLengkap,
        "kecamatan_id": kecamatanId,
        "kota_id": kotaId,
        "provinsi_id": provinsiId,
        "no_hp": noHp,
        "foto": foto,
        "tanggal_daftar": tanggalDaftar,
        "token": token,
        "referral_id": referralId,
        "province_id": provinceId,
        "province_name": provinceName,
        "city_id": cityId,
        "city_name": cityName,
        "postal_code": postalCode,
        "subdistrict_id": subdistrictId,
        "subdistrict_name": subdistrictName,
      };
}
