import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/function/checkColorIcon.dart';
import 'package:flutter_ecommerce_app/screens/ProductsScreen.dart';
import 'package:flutter_ecommerce_app/screens/SubCategoryScreen.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:sizer/sizer.dart';

class GridTilesCategory extends StatelessWidget {
  String name;
  Color colorIcon;
  IconData icon;
  String imageUrl;
  String slug;
  bool fromSubProducts = false;

  GridTilesCategory(
      {Key key,
      @required this.name,
      this.icon,
      this.colorIcon,
      this.imageUrl,
      this.slug,
      this.fromSubProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (fromSubProducts) {
          print(slug);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsScreen(
                      slug: Urls.IMAGE_SUB_KATEGORI_URL + slug,
                      name: name,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SubCategoryScreen(slug: slug, icon: icon)),
          );
        }
      },
      child: Card(
          color: Colors.white,
          elevation: 3,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 3.0.h,
                ),
                (icon != null)
                    ? Icon(
                        icon,
                        size: 12.5.w,
                        color: (fromSubProducts == true)
                            ? Colors.black54
                            : colorIcon,
                      )
                    : (imageUrl != null)
                        ? Image.network(
                            Urls.USER_IMAGE_URL + imageUrl,
                            width: 15.5.w,
                            height: 7.5.h,
                          )
                        : Image.asset(
                            "assets/images/toko.jpg",
                            width: 15.5.w,
                            height: 7.5.h,
                          ),
                SizedBox(
                  height: 1.0.h,
                ),
                Text(name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 11.0.sp))
              ],
            ),
          )),
    );
  }
}
