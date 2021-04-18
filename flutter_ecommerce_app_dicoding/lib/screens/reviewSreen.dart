import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/components/ReviewsWidget.dart';
import 'package:flutter_ecommerce_app/models/ReviewsModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

bool exist = true;
int totalUlasan = 0;

class ReviewScreen extends StatefulWidget {
  final double doubleRating;
  final int intRating;
  final String productId;

  ReviewScreen({this.intRating, this.doubleRating, @required this.productId});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ulasan",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0.sp),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
/*                     SizedBox(
                      height: 4.1.h,
                    ), */
                    Center(
                        child: Text(
                      widget.doubleRating.toStringAsFixed(1),
                      style: TextStyle(fontSize: 45.0.sp),
                    )),
                    Center(
                      child: Container(
                        height: 2.0.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            //bool exist = true;
                            exist = true;
                            if (i > 0) {
                              if (widget.intRating <= i) {
                                exist = false;
                              }
                            }

                            return (exist == true)
                                ? iconStar(Icons.star, 5.0.h)
                                : iconStar(Icons.star_outline, 5.0.h);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                child: FutureBuilder(
                  future: getDetailData(widget.productId),
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
              ))
        ],
      ),
    );
  }
}

//membangun detail view
Widget createDetailView(BuildContext context, AsyncSnapshot snapshot) {
  List<ReviewsModel> values = snapshot.data;
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: values.length,
      itemBuilder: (context, i) {
        double doubleRating =
            (values[i].rating != "null") ? double.parse(values[i].rating) : 0;
        int intRating = doubleRating.toInt();
        return ReviewsWidget(
          values: values,
          intRating: intRating,
          index: i,
        );
      },
    ),
  );
}

List<ReviewsModel> reviewDetails; //objeck review

//get data review dari http
Future<List<ReviewsModel>> getDetailData(String slug) async {
  reviewDetails = null;
  Response response;
  response = await get(Urls.REVIEWS_URL + slug);
  int statusCode = response.statusCode;
  final body = json.decode(response.body);
  print(body);
  if (statusCode == 200) {
    reviewDetails =
        (body as List).map((i) => ReviewsModel.fromJson(i)).toList();

    return reviewDetails;
  } else {
    return reviewDetails;
  }
}

//icon untuk rating
Icon iconStar(IconData icon, double size) {
  return Icon(
    icon,
    color: Colors.yellow[600],
    size: size,
  );
}
