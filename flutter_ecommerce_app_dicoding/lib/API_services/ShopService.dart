import 'dart:convert';
import 'package:flutter_ecommerce_app/models/MyShopModel.dart';
import 'package:flutter_ecommerce_app/models/SignUpModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class MyShopRepo {
  Future<MyShopModel> myShopCheck(String idKonsumen);
  Future<MyShopModel> myShopCreate(String idKonsumen);
}

class MyShopService implements MyShopRepo {
  MyShopModel myShopData;
  @override
  Future<MyShopModel> myShopCheck(String idKonsumen) async {
    Map data = {
      'id_konsumen': idKonsumen,
    };
    String bodyPost = json.encode(data);
    String url = Urls.MY_SHOP_CHECK;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200 || statusCode == 400) {
      myShopData = MyShopModel.fromJson(body);
      return myShopData;
    } else {
      return myShopData;
    }
  }

  Future<MyShopModel> myShopCreate(String idKonsumen) async {
    Map data = {
      'id_konsumen': idKonsumen,
    };
    String bodyPost = json.encode(data);
    String url = Urls.MY_SHOP_CREATE;

    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200 || statusCode == 400) {
      myShopData = MyShopModel.fromJson(body);
      return myShopData;
    } else {
      return myShopData;
    }
  }
}
