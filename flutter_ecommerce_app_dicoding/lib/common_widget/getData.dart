import 'dart:convert';

import 'package:flutter_ecommerce_app/models/CategoryModel.dart';
import 'package:flutter_ecommerce_app/models/subCategoryModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart';

List<CategoryModel> categoryDetails; //objeck kategori

//get data review dari http
Future<List<CategoryModel>> getDetailDataCategory() async {
  categoryDetails = null;
  Response response;
  response = await get(Urls.MARKET_URL + "kategori");
  int statusCode = response.statusCode;
  final body = json.decode(response.body);
  print(body);
  if (statusCode == 200) {
    categoryDetails =
        (body as List).map((i) => CategoryModel.fromJson(i)).toList();

    return categoryDetails;
  } else {
    return categoryDetails;
  }
}

List<SubCategoryModel> subCategoryDetails; //objeck kategori

//get data review dari http
Future<List<SubCategoryModel>> getDetailDataSubCategory(String slug) async {
  subCategoryDetails = null;
  Response response;
  response = await get(Urls.SUB_KATEGORI_URL + slug);
  int statusCode = response.statusCode;
  final body = json.decode(response.body);
  print("ini sub category ");
  print(body);
  if (statusCode == 200) {
    subCategoryDetails =
        (body as List).map((i) => SubCategoryModel.fromJson(i)).toList();

    return subCategoryDetails;
  } else {
    return subCategoryDetails;
  }
}
