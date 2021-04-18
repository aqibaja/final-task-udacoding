import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/function/checkColorIcon.dart';
import 'package:flutter_ecommerce_app/function/checkIcon.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/common_widget/GridTilesCategory.dart';
import 'package:flutter_ecommerce_app/models/subCategoryModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

List<SubCategoryModel> subCategories;
IconData currentIcon = FontAwesomeIcons.gamepad;
Color currentColor = Colors.black;

class SubCategoryPage extends StatefulWidget {
  final String slug;
  final IconData icon;

  SubCategoryPage({Key key, this.slug, this.icon}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
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
              return createListView(context, snapshot, widget.icon);
        }
      },
    );
  }
}

Widget createListView(
    BuildContext context, AsyncSnapshot snapshot, IconData icon) {
  List<SubCategoryModel> values = snapshot.data;
  return GridView.count(
    crossAxisCount: 3,
//    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(1.0),
    childAspectRatio: 8.0 / 9.0,
    children: List<Widget>.generate(values.length, (index) {
      currentIcon = checkIcon(values[index].icon);
      currentColor = checkColorIcon(values[index].icon);
      print(values[index].idSubKategori);
      return GridTile(
          child: GridTilesCategory(
        name: values[index].nameSubCategory,
        //imageUrl: values[index].imageUrl,
        icon: icon,
        colorIcon: currentColor,
        fromSubProducts: true,
        slug: values[index].idSubKategori,
      ));
    }),
  );
}

Future<List<SubCategoryModel>> getCategoryList(String slug) async {
  subCategories = null;
  if (subCategories == null) {
    Response response;
    response = await get(Urls.SUB_KATEGORI_URL + slug);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(statusCode);
    print(body);
    if (statusCode == 200) {
      subCategories =
          (body as List).map((i) => SubCategoryModel.fromJson(i)).toList();

      return subCategories;
    } else {
      return subCategories;
    }
  } else {
    return subCategories;
  }
}

// https://api.evaly.com.bd/core/public/categories/?parent=bags-luggage-966bc8aac     sub cate by slug
