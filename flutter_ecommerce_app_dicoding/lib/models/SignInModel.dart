// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
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
    this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
      };
}
