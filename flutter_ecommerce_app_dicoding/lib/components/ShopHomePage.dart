import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/common_widget/GridTilesCategory.dart';
import 'package:flutter_ecommerce_app/models/ShopModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart';

List<ShopModel> shop;

class ShopHomePage extends StatefulWidget {
  final String slug;
  final bool isSubList;

  ShopHomePage({Key key, this.slug, this.isSubList = false}) : super(key: key);

  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryList(widget.slug, widget.isSubList),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot, widget.isSubList);
        }
      },
    );
  }
}

Widget createListView(
    BuildContext context, AsyncSnapshot snapshot, bool isSubList) {
  List<ShopModel> values = snapshot.data;
  return GridView.count(
    crossAxisCount: 3,
//    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(1.0),
    childAspectRatio: 8.0 / 9.0,
    children: List<Widget>.generate(values.length, (index) {
      return GridTile(
          child: GridTilesCategory(
        name: values[index].shopName,
        imageUrl: values[index].shopImage,
      ));
    }),
  );
}

Future<List<ShopModel>> getCategoryList(String slug, bool isSubList) async {
  if (isSubList) {
    shop = null;
  }
  if (shop == null) {
    Response response;
    response = await get(Urls.MARKET_URL + slug);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(statusCode);
    print(body);
    if (statusCode == 200) {
      shop = (body as List).map((i) => ShopModel.fromJson(i)).toList();

      return shop;
    } else {
      return shop;
    }
  } else {
    return shop;
  }
}
