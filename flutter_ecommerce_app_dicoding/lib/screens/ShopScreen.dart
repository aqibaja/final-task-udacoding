import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/common_widget/SearchWidget.dart';
import 'package:flutter_ecommerce_app/function/checkColorIcon.dart';
import 'package:flutter_ecommerce_app/function/checkIcon.dart';
import 'package:flutter_ecommerce_app/models/CategoryModel.dart';
import 'package:flutter_ecommerce_app/models/subCategoryModel.dart';
import 'package:flutter_ecommerce_app/screens/ProductsScreen.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ecommerce_app/common_widget/getData.dart';
import 'package:sizer/sizer.dart';

String selection = "1";
String selectionSub = "1";
String selectionSlugCategory = Urls.ALL_KATEGORI_URL + "1";

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SearchWidget(),
            Expanded(
                flex: 3,
                child: Container(
                  child: FutureBuilder(
                    future: getDetailDataCategory(),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return CircularProgress();
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return createDetailView(context, snapshot);
                      }
                    },
                  ),
                )),
            SizedBox(
              height: 2.0.h,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: FutureBuilder(
                    future: getDetailDataSubCategory(selection),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return CircularProgress();
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return createDetailViewSub(context, snapshot);
                      }
                    },
                  ),
                )),
            SizedBox(
              height: 2.0.h,
            ),
            Expanded(
              flex: 15,
              child: Container(
                //color: Colors.white,
                child: ProductListWidget(
                  slug: (selectionSlugCategory == "")
                      ? Urls.IMAGE_SUB_KATEGORI_URL + selectionSub
                      : selectionSlugCategory,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///ini untuk membuat detail view daru data
  Widget createDetailView(BuildContext context, AsyncSnapshot snapshot) {
    List<CategoryModel> values = snapshot.data;
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        itemBuilder: (context, i) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selection = values[i].idKategori;
                  selectionSlugCategory =
                      Urls.ALL_KATEGORI_URL + values[i].idKategori;
                });
              },
              child: detailViewCategory(values, i));
        },
      ),
    );
  }

  ///ini untuk membuat detail view daru data subCategory
  Widget createDetailViewSub(BuildContext context, AsyncSnapshot snapshot) {
    List<SubCategoryModel> values = snapshot.data;
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
              detailViewSubCategory(values, i),
              SizedBox(
                width: 3.0.w,
              )
            ],
          );
        },
      ),
    );
  }

  IconData currentIcon = FontAwesomeIcons.gamepad;
  Color currentColor = Colors.black;

//ini view dari category
  Container detailViewCategory(List<CategoryModel> values, int i) {
    currentIcon = checkIcon(values[i].icon);
    currentColor = (selection == values[i].idKategori)
        ? checkColorIcon(values[i].icon)
        : Colors.black45;
    return Container(
      width: 25.0.w,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: currentColor,
            radius: 25,
            child: Icon(
              currentIcon,
              color: Colors.white,
            ),
          ),
          Text(
            values[i].name_category,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

//ini view dari sub category
  Widget detailViewSubCategory(List<SubCategoryModel> values, int i) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectionSub = values[i].idSubKategori;
          selectionSlugCategory = "";
        });
      },
      child: Container(
        height: 2.0.h,
        child: Text(
          values[i].nameSubCategory,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFAA292E),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
