import 'dart:convert';
import 'package:flutter_ecommerce_app/models/FavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/ListZonkFavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/addDeleteCartModel.dart';
import 'package:flutter_ecommerce_app/models/listCart.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class CartRepo {
  Future<AddDeleteCartModel> addCart(String konsumenId, String productId);
  Future<AddDeleteCartModel> deleteCart(String konsumenId, String productId);
  Future<AddDeleteCartModel> addTotalCart(String konsumenId, String productId);
  Future listCart(String konsumenId);
}

class CartService extends CartRepo {
  List<FavoriteModel> favoriteData;
  AddDeleteCartModel addData;
  AddDeleteCartModel deleteData;
  ListZonkFavoriteModel noDataList;
  List<ListCartModel> listCartData;

  @override
  Future<AddDeleteCartModel> addCart(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-add-cart";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    ;
    if (statusCode == 200) {
      addData = AddDeleteCartModel.fromJson(body);
      return addData;
    } else {
      return addData;
    }
  }

  @override
  Future<AddDeleteCartModel> addTotalCart(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-add-total-cart";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);

    if (statusCode == 200) {
      addData = AddDeleteCartModel.fromJson(body);
      return addData;
    } else {
      return addData;
    }
  }

  @override
  Future<AddDeleteCartModel> deleteCart(
      String konsumenId, String productId) async {
    String url = Urls.MARKET_URL + "product-remove-total-cart";

    Map data = {'id_konsumen': konsumenId, 'id_product': productId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      deleteData = AddDeleteCartModel.fromJson(body);
      return deleteData;
    } else {
      return deleteData;
    }
  }

  @override
  Future listCart(String konsumenId) async {
    String url = Urls.MARKET_URL + "product-list-cart";

    Map data = {'id_konsumen': konsumenId};
    String bodyPost = json.encode(data);
    Response response = await http.post(url,
        body: bodyPost, headers: {"Content-Type": "application/json"});
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      listCartData =
          (body as List).map((i) => ListCartModel.fromJson(i)).toList();
      return listCartData;
    } else {
      return statusCode;
    }
  }
}
