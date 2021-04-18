import 'dart:convert';
import 'package:flutter_ecommerce_app/models/DiscountModel.dart';
import 'package:flutter_ecommerce_app/models/ProductsModel.dart';
import 'package:flutter_ecommerce_app/models/PupularModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ProductRepo {
  Future<List<PopularModel>> getDetailPopular();
  Future<List<DiscountModel>> getDetailDiscount();
  Future<List<ProductModels>> getDetailProduct(String productId);
}

class ProductService extends ProductRepo {
  List<PopularModel> popularData;
  List<DiscountModel> discountData;
  List<ProductModels> productData;

  @override
  Future<List<PopularModel>> getDetailPopular() async {
    String url = Urls.MARKET_URL + "product-terpopuler";

    Response response = await http.get(url);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      popularData =
          (body as List).map((i) => PopularModel.fromJson(i)).toList();
      return popularData;
    } else {
      return popularData;
    }
  }

  @override
  Future<List<DiscountModel>> getDetailDiscount() async {
    String url = Urls.MARKET_URL + "product-diskon-terbaru";

    Response response = await http.get(url);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      discountData =
          (body as List).map((i) => DiscountModel.fromJson(i)).toList();
      return discountData;
    } else {
      return discountData;
    }
  }

  @override
  Future<List<ProductModels>> getDetailProduct(String productId) async {
    String url = Urls.PRODUCT_URL + productId;

    Response response = await http.get(url);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      productData =
          (body as List).map((i) => ProductModels.fromJson(i)).toList();
      return productData;
    } else {
      return productData;
    }
  }
}
