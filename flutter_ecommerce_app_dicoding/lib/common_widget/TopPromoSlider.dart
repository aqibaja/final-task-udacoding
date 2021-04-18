import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/SliderModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import 'CircularProgress.dart';

List<SliderModel> imageSlider;
List<dynamic> list = [];

class TopPromoSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot, list);
            }
        }
      },
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot, List list) {
  List<SliderModel> values = snapshot.data;
  int idk = values.length;
  //memasukkan image slider dari database ke dalam list
  list = [];
  for (int i = 0; i < idk; i++) {
    print(Urls.ROOT_URL + "/upload/banner/" + values[0].imageUrl);
    list.add(Image.network(
      Urls.ROOT_URL + "/upload/banner/" + values[i].imageUrl,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    ));
  }
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Container(
        height: 16.0.h,
        width: double.infinity,
        child: Carousel(
          images: list, // list image slider
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.purple,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.black54.withOpacity(0.2),
          borderRadius: true,
          radius: Radius.circular(20),
          moveIndicatorFromBottom: 180.0,
          noRadiusForIndicator: true,
        )),
  );
}

Future<List<SliderModel>> getImage() async {
  if (imageSlider == null) {
    Response response;
    response = await get(Urls.MARKET_URL + "slider/");
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(statusCode);
    print(body);
    if (statusCode == 200) {
      imageSlider = (body as List).map((i) => SliderModel.fromJson(i)).toList();

      return imageSlider;
    } else {
      return imageSlider;
    }
  } else {
    return imageSlider;
  }
}
