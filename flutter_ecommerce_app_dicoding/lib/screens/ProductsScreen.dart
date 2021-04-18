import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common_widget/AppBarWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/common_widget/GridTilesProducts.dart';
import 'package:flutter_ecommerce_app/models/CatalogueModel.dart';
import 'package:flutter_ecommerce_app/models/ProductsModel.dart';
import 'package:http/http.dart';

List<CatalogueModel> products;

class ProductsScreen extends StatefulWidget {
  final String name;
  final String slug;

  ProductsScreen({Key key, @required this.name, @required this.slug})
      : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ProductListWidget(
            slug: widget.slug,
          )),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final String slug;

  ProductListWidget({Key key, this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductList(slug, false),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
  }
}

Future<List<CatalogueModel>> getProductList(String slug, bool isSubList) async {
  products = null;
  if (products == null) {
    Response response;
    print(slug);
    response = await get(slug);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200) {
      products = (body as List).map((i) => CatalogueModel.fromJson(i)).toList();
      return products;
    } else {
      return products;
    }
  } else {
    return products;
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<CatalogueModel> results = snapshot.data;
  var mediaQueryData = MediaQuery.of(context);
  final double widthScreen = mediaQueryData.size.width;
  final double appBarHeight = kToolbarHeight;
  final double paddingTop = mediaQueryData.padding.top;
  final double paddingBottom = mediaQueryData.padding.bottom;
  final double heightScreen =
      (mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight) /
          1.1;
  return GridView.count(
    crossAxisCount: 2,
//    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(1.0),
    childAspectRatio: widthScreen / heightScreen,
    children: List<Widget>.generate(results.length, (index) {
      List<String> _image = [];
      _image = splitImage(results[index].imageUrls);
      print(results[index].rating);
      print(results[index].priceDiscount);
      return GridTile(
          child: GridTilesProducts(
        name: results[index].name,
        imageUrl: _image,
        slug: results[index].idProduct,
        price: results[index].price,
        priceDiscount: results[index].priceDiscount,
        rating: results[index].rating,
      ));
    }),
  );
}

//melakukan pemisahan ketika image lebih dari satu
List<String> splitImage(String imageUrls) {
  List<String> result = imageUrls.split(';');
  print(result);
  return result;
}
