import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce_app/screens/ProductDetailScreen.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: "id_ID");
bool exist = true;
int intRating;

class GridTilesProducts extends StatelessWidget {
  final String name;
  final List<String> imageUrl;
  final String slug;
  final String price;
  final String priceDiscount;
  final bool fromSubProducts;
  final String rating;

  GridTilesProducts(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      this.slug,
      this.priceDiscount,
      this.rating,
      @required this.price,
      this.fromSubProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(priceDiscount);
    // bool fromSubProducts = false;
    print("nomor produk" + slug);
    print(rating);
    double tempRating = (rating != "null") ? double.parse(rating) : 0;
    intRating = tempRating.toInt();
    print(intRating);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    slug: slug,
                    rating: rating,
                  )),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            elevation: 3,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 25.0.h,
                    child: Image.network(
                      Urls.PRODUCT_IMAGE_URL + imageUrl[0],
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        // Appropriate logging or analytics, e.g.
                        // myAnalytics.recordError(
                        //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                        //   exception,
                        //   stackTrace,
                        // );
                        return Image.asset("assets/images/no-image.png");
                      },
                    ),
                  ),
                  /* CachedNetworkImage(
                    imageUrl:
                        Urls.PRODUCT_IMAGE_URL +
                            imageUrl[0],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.no_photography_outlined,
                      size: 150,
                    ),
                  ), */
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 7),
                    child: Text(
                        (name.length <= 40 ? name : name.substring(0, 40)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF444444),
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                  Container(
                    height: 1.0.h,
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.only(right: 10, bottom: 1.0.h, left: 3.0.w),
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          //bool exist = true;
                          exist = true;
                          if (i > 0) {
                            if (intRating <= i) {
                              exist = false;
                            }
                          }

                          return (exist == true)
                              ? iconStar(Icons.star)
                              : iconStar(Icons.star_outline);
                        },
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.only(left: 3.0.w, right: 10, top: 1.0.h),
                    child: Text(
                        "${(priceDiscount != "null") ? formatCurrency.format(int.parse(priceDiscount)) : formatCurrency.format(int.parse(price))}",
                        style: TextStyle(
                            color: (price != null)
                                ? Color(0xFFf67426)
                                : Color(0xFF0dc2cd),
                            fontFamily: 'Roboto-Light.ttf',
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                  (price != priceDiscount && priceDiscount != "null")
                      ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            left: 3.0.w,
                            right: 10,
                          ),
                          child: Text(
                              "${formatCurrency.format(int.parse(price))}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: (price != null)
                                      ? Color(0xFFf67426)
                                      : Color(0xFF0dc2cd),
                                  fontFamily: 'Roboto-Light.ttf',
                                  fontSize: 9.0.sp,
                                  fontWeight: FontWeight.w500)),
                        )
                      : Container(),
                ],
              ),
            )),
      ),
    );
  }

  Icon iconStar(IconData icon) {
    return Icon(
      icon,
      color: Colors.yellow[600],
    );
  }
}
