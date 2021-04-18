import 'dart:convert';
import 'package:flutter_ecommerce_app/models/DetailKonsumenModel.dart';
import 'package:flutter_ecommerce_app/models/KonsumenFailModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class KonsumenRepo {
  Future<dynamic> getDetailData(String idKonsumen);
}

class KonsumenService implements KonsumenRepo {
  DetailKonsumenModel konsumenData;
  KonsumenFailModel konsumenFailData;
  @override
  Future<dynamic> getDetailData(String idKonsumen) async {
    Map data = {
      'id_konsumen': idKonsumen,
    };
    String bodyPost = json.encode(data);
    String url = Urls.DETAIL_KONSUMEN_URL;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 201) {
      konsumenData = DetailKonsumenModel.fromJson(body);
      return konsumenData;
    } else if (statusCode == 400) {
      konsumenFailData = KonsumenFailModel.fromJson(body);
      return konsumenFailData;
    } else {
      return konsumenFailData;
    }
  }
}
