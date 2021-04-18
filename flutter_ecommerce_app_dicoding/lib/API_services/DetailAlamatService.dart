import 'dart:convert';
import 'package:flutter_ecommerce_app/models/KecamatanModel.dart';
import 'package:flutter_ecommerce_app/models/KotaModel.dart';
import 'package:flutter_ecommerce_app/models/provinsiModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class AlamatRepo {
  Future<List<ProvinsiModel>> getDetailProvinsi();
  Future<dynamic> getDetailKota(String provinceId);
  Future<dynamic> getDetailKecamatan(String cityId);
}

class AlamatService implements AlamatRepo {
  List<ProvinsiModel> provinsiData;
  List<KotaModel> kotaData;
  List<KecamatanModel> kecamatanKota;

  @override
  Future<List<ProvinsiModel>> getDetailProvinsi() async {
    String url = Urls.MARKET_URL + "detail-provinsi";

    Response response = await http.get(url);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      provinsiData =
          (body as List).map((i) => ProvinsiModel.fromJson(i)).toList();
      return provinsiData;
    } else {
      return provinsiData;
    }
  }

  @override
  Future<dynamic> getDetailKota(String provinceId) async {
    String url = Urls.MARKET_URL + "detail-kota";

    Map data = {
      'province_id': provinceId,
    };
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      kotaData = (body as List).map((i) => KotaModel.fromJson(i)).toList();
      return kotaData;
    } else {
      return kotaData;
    }
  }

  @override
  Future<dynamic> getDetailKecamatan(String cityId) async {
    String url = Urls.MARKET_URL + "detail-kecamatan";

    Map data = {
      'city_id': cityId,
    };
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      kecamatanKota =
          (body as List).map((i) => KecamatanModel.fromJson(i)).toList();
      return kecamatanKota;
    } else {
      return kecamatanKota;
    }
  }
}
