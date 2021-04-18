import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/function/checkColorIcon.dart';
import 'package:flutter_ecommerce_app/function/checkIcon.dart';
import 'package:flutter_ecommerce_app/models/CategoryModel.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/common_widget/GridTilesCategory.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

List<CategoryModel> categories;

IconData currentIcon = FontAwesomeIcons.gamepad;
Color currentColor = Colors.black;

class CategoryPage extends StatefulWidget {
  final String slug;

  CategoryPage({Key key, this.slug}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryList(widget.slug),
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

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<CategoryModel> values = snapshot.data;
  return GridView.count(
    crossAxisCount: 3,
//    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(1.0),
    childAspectRatio: 7.7 / 9.0,
    children: List<Widget>.generate(values.length, (index) {
      currentIcon = checkIcon(values[index].icon);
      currentColor = checkColorIcon(values[index].icon);
      return GridTile(
          child: GridTilesCategory(
        name: values[index].name_category,
        //imageUrl: values[index].imageUrl,
        icon: currentIcon,
        colorIcon: currentColor,
        fromSubProducts: false,
        slug: values[index].idKategori,
      ));
    }),
  );
}

Future<List<CategoryModel>> getCategoryList(String slug) async {
  categories = null;
  if (categories == null) {
    Response response;
    response = await get(Urls.MARKET_URL + slug);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(statusCode);
    print(body);
    if (statusCode == 200) {
      categories =
          (body as List).map((i) => CategoryModel.fromJson(i)).toList();

      return categories;
    } else {
      return categories;
    }
  } else {
    return categories;
  }
}

// https://api.evaly.com.bd/core/public/categories/?parent=bags-luggage-966bc8aac     sub cate by slug
