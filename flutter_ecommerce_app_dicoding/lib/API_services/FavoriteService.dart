import 'dart:convert';
import 'package:flutter_ecommerce_app/models/FavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/ListZonkFavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/addDeleteFavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/listFavorite.dart';
import 'package:flutter_ecommerce_app/models/provinsiModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class FavoriteRepo {
  Future<List<FavoriteModel>> getDetailFavorite(
      String konsumenId, String productId);
  Future<AddDeleteFavoriteModel> addFavorite(
      String konsumenId, String productId);
  Future<AddDeleteFavoriteModel> deleteFavorite(
      String konsumenId, String productId);
  Future listFavorite(String konsumenId);
}

class FavoriteService extends FavoriteRepo {
  List<FavoriteModel> favoriteData;
  AddDeleteFavoriteModel addData;
  AddDeleteFavoriteModel deleteData;
  ListZonkFavoriteModel noDataList;
  List<ListFavoriteModel> listFavoriteData;
  @override
  Future<List<FavoriteModel>> getDetailFavorite(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-check-favorite";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);

    if (statusCode == 200) {
      favoriteData =
          (body as List).map((i) => FavoriteModel.fromJson(i)).toList();
      return favoriteData;
    } else {
      return favoriteData;
    }
  }

  @override
  Future<AddDeleteFavoriteModel> addFavorite(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-add-favorite";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    ;
    if (statusCode == 200) {
      addData = AddDeleteFavoriteModel.fromJson(body);
      return addData;
    } else {
      return addData;
    }
  }

  @override
  Future<AddDeleteFavoriteModel> deleteFavorite(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-delete-favorite";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      deleteData = AddDeleteFavoriteModel.fromJson(body);
      return deleteData;
    } else {
      return deleteData;
    }
  }

  @override
  Future listFavorite(String konsumenId) async {
    String url = Urls.MARKET_URL + "product-list-favorite";

    Map data = {'id_konsumen': konsumenId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      listFavoriteData =
          (body as List).map((i) => ListFavoriteModel.fromJson(i)).toList();
      return listFavoriteData;
    } else {
      return statusCode;
    }
  }
}
