import 'dart:convert';
import 'dart:io';
import 'package:flutter_ecommerce_app/models/EditKonsumenModel.dart';
import 'package:flutter_ecommerce_app/models/KonsumenFailModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class KonsumenEditRepo {
  Future<dynamic> getDetailData(
    int idKonsumen,
    String username,
    String password,
    String namaLengkap,
    String email,
    String jenisKelamin,
    String tanggalLahir,
    String tempatLahir,
    String alamatLengkap,
    int kecamatanId,
    int kotaId,
    int provinsiId,
    String noHp,
    File foto,
  );
}

class KonsumenEditService implements KonsumenEditRepo {
  EditKonsumenModel konsumenData;
  KonsumenFailModel konsumenFailData;

  @override
  Future<dynamic> getDetailData(
    int idKonsumen,
    String username,
    String password,
    String namaLengkap,
    String email,
    String jenisKelamin,
    String tanggalLahir,
    String tempatLahir,
    String alamatLengkap,
    int kecamatanId,
    int kotaId,
    int provinsiId,
    String noHp,
    File foto,
  ) async {
    Map data = {
      'id_konsumen': idKonsumen,
      'image': foto,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'username': username,
      'email': email,
      'tanggal_lahir': tanggalLahir,
      'tempat_lahir': tempatLahir,
      'alamat_lengkap': alamatLengkap,
      'no_hp': noHp,
      'kecamatan_id': kecamatanId,
      'kota_id': kotaId,
      'provinsi_id': provinsiId,
    };
    //String bodyPost = json.encode(data);
    String url = Urls.EDIT_KONSUMEN_URL;
    final uri = Uri.parse(url);

    if (foto != null) {
      var request = http.MultipartRequest('POST', uri);
      request.fields['id_konsumen'] = idKonsumen.toString();
      request.fields['nama_lengkap'] = namaLengkap;
      request.fields['jenis_kelamin'] = jenisKelamin;
      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['tanggal_lahir'] = tanggalLahir;
      request.fields['no_hp'] = noHp;
      request.fields['kecamatan_id'] = kecamatanId.toString();
      request.fields['kota_id'] = kotaId.toString();
      request.fields['provinsi_id'] = provinsiId.toString();
      var pic = await http.MultipartFile.fromPath('image', foto.path);
      request.files.add(pic);
      var response = await request.send();
      int statusCode = response.statusCode;
      var responseBody = await http.Response.fromStream(response);
      final body = json.decode(responseBody.body);

      if (statusCode == 200) {
        print("berhasil upload!!!");
        print(body);
        konsumenData = EditKonsumenModel.fromJson(body);
        return konsumenData;
      } else {
        print("gagal upload!!!");
        print(body);
        konsumenData = EditKonsumenModel.fromJson(body);
        return konsumenData;
      }
    } else {
      String bodyPost = json.encode(data);
      Response response = await http.post(url,
          body: bodyPost, headers: {"Content-Type": "application/json"});
      int statusCode = response.statusCode;
      final body = json.decode(response.body);
      print(body);
      if (statusCode == 200) {
        konsumenData = EditKonsumenModel.fromJson(body);
        return konsumenData;
      } else if (statusCode == 400) {
        konsumenFailData = KonsumenFailModel.fromJson(body);
        return konsumenFailData;
      } else {
        return konsumenFailData;
      }
    }
  }
}
