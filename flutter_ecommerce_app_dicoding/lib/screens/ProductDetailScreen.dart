import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/favorite_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/product_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/wish_bloc.dart';
import 'package:flutter_ecommerce_app/common_widget/AppBarWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_ecommerce_app/common_widget/LoadingProgress.dart';
import 'package:flutter_ecommerce_app/components/AppSignIn.dart';
import 'package:flutter_ecommerce_app/function/splitString.dart';
import 'package:flutter_ecommerce_app/screens/reviewSreen.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_ecommerce_app/models/ProductsModel.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:http/http.dart';
import 'ProductsScreen.dart';
import 'package:simple_html_css/simple_html_css.dart';

bool exist = true;
int intRating;
double doubleRating;
List<ProductModels> productDetails;
List<String> _imgList = [];
AuthBloc _authBloc;
FavoriteBloc _favoriteBloc;
ProductBloc _productBloc;
WishBloc _wishBloc;
CartBloc _cartBloc;

final formatCurrency = new NumberFormat.simpleCurrency(
    locale: "id_ID"); //untuk memngubah int menjadi format uang

class ProductDetailScreen extends StatefulWidget {
  final String slug;
  final String rating;

  ProductDetailScreen({Key key, @required this.slug, @required this.rating})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _wishBloc = BlocProvider.of<WishBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _productBloc.add(InitialEventDetailProduct());
    _authBloc.add(ClearEvent());
    _favoriteBloc.add(ClearEventFavorite());

    doubleRating = (widget.rating != "null") ? double.parse(widget.rating) : 0;
    intRating = doubleRating.toInt();
    String konsumenId;
    String productId;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          _authBloc.add(CheckLoginEvent());
        }
        if (state is SignInOut) {
          //_favoriteBloc.add(ClearEventFavorite());
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductDetailInitial) {
                _productBloc
                    .add(ViewProductDetailEvent(productId: widget.slug));
              }
              if (state is ProductDetailLoading) {
                return Scaffold(body: LoadingProgress());
              }
              if (state is ProductDetailLoaded) {
                print("loadeedd!! with no login");
                productId = state.productModel[0].idProduct;
                return Scaffold(
                  backgroundColor: Color(0xFFfafafa),
                  appBar: appBarWidget(context),
                  body:
                      createDetailView(context, state.productModel, intRating),
                  bottomNavigationBar: BottomNavBar(
                    konsumenId: konsumenId,
                    productId: productId,
                  ),
                );
              }
              return Container();
            },
          );
        }
        if (state is SignInSaved) {
          konsumenId = state.idUSerSave;
          print("tersimpan!!!");
          //_favoriteBloc.add(ClearEventFavorite());
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductDetailInitial) {
                _productBloc
                    .add(ViewProductDetailEvent(productId: widget.slug));
              }
              if (state is ProductDetailLoading) {
                return Scaffold(body: LoadingProgress());
              }
              if (state is ProductDetailLoaded) {
                print("loadeedd!!");
                productId = state.productModel[0].idProduct;
                return Scaffold(
                  backgroundColor: Color(0xFFfafafa),
                  appBar: appBarWidget(context),
                  body:
                      createDetailView(context, state.productModel, intRating),
                  bottomNavigationBar: BottomNavBar(
                    konsumenId: konsumenId,
                    productId: productId,
                  ),
                );
              }
              return Container();
            },
          );
        }
        return Scaffold(body: LoadingProgress());

        /* return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductDetailInitial) {
              _productBloc.add(ViewProductDetailEvent(productId: widget.slug));
            }
            if (state is ProductDetailLoading) {
              return Scaffold(body: LoadingProgress());
            }
            if (state is ProductDetailLoaded) {
              productId = state.productModel[0].idProduct;
              return Scaffold(
                backgroundColor: Color(0xFFfafafa),
                appBar: appBarWidget(context),
                body: createDetailView(context, state.productModel, intRating),
                bottomNavigationBar: BottomNavBar(
                  konsumenId: konsumenId,
                  productId: productId,
                ),
              );
            }
            return Container();
          },
        ); */
      },
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String konsumenId;
  final String productId;
  BottomNavBar({this.konsumenId, this.productId});
  @override
  Widget build(BuildContext context) {
    _favoriteBloc.add(ClearEventFavorite());
    print(konsumenId);
    print(productId);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: <Widget>[
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteInitial && konsumenId != null) {
                _favoriteBloc.add(CheckFavoriteEvent(
                    konsumenId: konsumenId, productId: productId));
              }
              if (state is FavoriteLoading) {
                print("favorite loading");
                EasyLoading.show(status: 'loading...');
              }
              if (state is FavoriteSuccess) {
                print(state.favoriteModel[0].idKonsumen);
                print("sukses check favorite");
                EasyLoading.dismiss();
                return IconButton(
                  onPressed: () {
                    _favoriteBloc.add(DeleteFavoriteEvent(
                        konsumenId: konsumenId, productId: productId));
                  },
                  icon: Icon(Icons.favorite),
                  color: Color(0xFF5e5e5e),
                );
              }
              if (state is FavoriteZonk) {
                EasyLoading.dismiss();
                return IconButton(
                  onPressed: () {
                    print(productId);
                    _favoriteBloc.add(AddFavoriteEvent(
                        konsumenId: konsumenId, productId: productId));
                  },
                  icon: Icon(Icons.favorite_border),
                  color: Color(0xFF5e5e5e),
                );
              }
              if (state is FavoriteAddLoading) {
                print("loading! add favorite");
                EasyLoading.show(status: 'loading...');
              }
              if (state is FavoriteAddSuccess) {
                if (state.addFavoriteModel.success == "true") {
                  _wishBloc.add(ListFavoriteEvent(konsumenId: konsumenId));
                  _favoriteBloc.add(CheckFavoriteEvent(
                      konsumenId: konsumenId, productId: productId));
                }
              }
              if (state is FavoriteDeleteLoading) {
                print("loading! delete favorite");
                EasyLoading.show(status: 'loading...');
              }
              if (state is FavoriteDeleteSuccess) {
                if (state.deleteFavoriteModel.success == "true") {
                  _wishBloc.add(ListFavoriteEvent(konsumenId: konsumenId));
                  _favoriteBloc.add(CheckFavoriteEvent(
                      konsumenId: konsumenId, productId: productId));
                }
              }
              return IconButton(
                onPressed: () {
                  print(productId);
                  konsumenId == null
                      ? Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AppSignIn()))
                      : _favoriteBloc.add(AddFavoriteEvent(
                          konsumenId: konsumenId, productId: productId));
                },
                icon: Icon(Icons.favorite_border),
                color: Color(0xFF5e5e5e),
              );
            },
          ),
          Spacer(),
          RaisedButton(
            elevation: 0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                side: BorderSide(color: Color(0xFFfef2f2))),
            onPressed: () {
              _cartBloc.add(
                  AddCartEvent(konsumenId: konsumenId, productId: productId));
              _cartBloc.add(ClearEventCart());
            },
            color: Colors.grey[300],
            /* Color(0xFFfef2f2), */
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
              child: Text("tambah keranjang".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black /* Color(0xFFff665e) */)),
            ),
          ),
          RaisedButton(
            elevation: 0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                side: BorderSide(color: Color(0xFFfef2f2))),
            onPressed: () {},
            color: Colors.black87 /* Color(0xFFff665e) */,
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
              child: Text("Beli Sekarang".toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300] /* Color(0xFFFFFFFF) */)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget createDetailView(
    BuildContext context, List<ProductModels> values, int rating) {
  return DetailScreen(
    productDetails: values,
    rating: rating,
  );
}

class DetailScreen extends StatefulWidget {
  final List<ProductModels> productDetails;
  final int rating;

  DetailScreen({Key key, this.productDetails, this.rating}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _current = 0;

  //map untuk indikator dibawah image carousel
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String image = widget.productDetails[0].imageUrls;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildCarouselSlider(image), // image slider
          SizedBox(
            height: 1.0.h,
          ),
          indicatorSlider(), // indikator ketika image slider berjalan
          rating(widget.rating, context,
              widget.productDetails[0].idProduct), // feature yang dapat ditekan
          SizedBox(
            height: 1.0.h,
          ),
          feature("Harga", widget.productDetails[0].priceDiscount,
              true), // fitur2 seperti berat, variasi, dan lain2
          SizedBox(
            height: 1.0.h,
          ),
          feature(
              "Berat",
              (widget.productDetails[0].berat != null)
                  ? widget.productDetails[0].berat
                  : "Tidak diketahui",
              false), // fitur2 seperti berat, variasi, dan lain2

          (widget.productDetails[0].nameVariant !=
                  null) // untuk menampilkan semua variant
              ? ListView.builder(
                  shrinkWrap: true, //agar bisa masuk di column
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.productDetails.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          height: 1.0.h,
                          color: Color(0xFFfafafa),
                        ),
                        featureVariant(widget.productDetails[i].nameVariant,
                            widget.productDetails[i].detailVariant)
                      ],
                    );
                  },
                )
              : Container(),
          SizedBox(
            height: 1.0.h,
          ),
          specification(), // spesifikasinya
          SizedBox(
            height: 1.0.h,
          ),
          description(context) // deskripsinya
        ],
      ),
    );
  }

  Container description(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      color: Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Deskripsi",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF565656))),
          SizedBox(
            height: 2.0.h,
          ),
          RichText(
            text: HTML.toTextSpan(
              context,
              widget.productDetails[0].detailDeskripsi,
              defaultTextStyle: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4c4c4c)
                  // etc etc
                  ),
            ),

            //...
          )
        ],
      ),
    );
  }

  Container specification() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      color: Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Spesifikasi",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF565656))),
          SizedBox(
            height: 2.0.h,
          ),
          Text(widget.productDetails[0].deskripsi,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4c4c4c))),
        ],
      ),
    );
  }

  Container feature(
    String fitur,
    String isian,
    bool harga,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      color: Color(0xFFFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(fitur.toUpperCase(),
              style: TextStyle(
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF565656))),
          Row(
            children: [
              Text(
                  (harga == true)
                      ? '${(isian != "null") ? formatCurrency.format(int.parse(isian)) : formatCurrency.format(int.parse(widget.productDetails[0].price))}'
                      : isian + " Gram",
                  style: TextStyle(
                      color: Color(0xFFf67426),
                      fontFamily: 'Roboto-Light.ttf',
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                width: 1.0.w,
              ),
              (harga == true)
                  ? (isian != widget.productDetails[0].price && isian != "null")
                      ? Text(
                          "${formatCurrency.format(int.parse(widget.productDetails[0].price))}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Color(0xFFf67426),
                              fontFamily: 'Roboto-Light.ttf',
                              fontSize: 9.0.sp,
                              fontWeight: FontWeight.w500))
                      : Container()
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Container featureVariant(
    String fitur,
    String isian,
  ) {
    List<String> isianTerpisah = splitString(isian); // memisahkan semicolon / ;

    //Memasuskkan semua isian List kesalam widget Text
    Widget methodPemisahList() {
      return Row(
        children: <Widget>[
          for (var item in isianTerpisah)
            Text(item + ", ",
                style: TextStyle(
                    color: (widget.productDetails[0].price != null)
                        ? Color(0xFFf67426)
                        : Color(0xFF0dc2cd),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500)),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(fitur.toUpperCase(),
                      style: TextStyle(
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF565656))),
                  methodPemisahList(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rating(int rating, BuildContext context, String produkId) {
    print("ini rating !!!" + rating.toString());
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewScreen(
                    doubleRating: doubleRating,
                    intRating: rating,
                    productId: produkId,
                  ))),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        color: Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Rating".toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF565656))),
            Container(
              height: 2.0.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i) {
                  //bool exist = true;
                  exist = true;
                  if (i > 0) {
                    if (rating <= i) {
                      exist = false;
                    }
                  }

                  return (exist == true)
                      ? iconStar(Icons.star)
                      : iconStar(Icons.star_outline);
                },
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF999999),
            )
          ],
        ),
      ),
    );
  }

  Row indicatorSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(_imgList, (index, url) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index ? Colors.redAccent : Colors.green,
          ),
        );
      }),
    );
  }

  //image slider diatas
  CarouselSlider buildCarouselSlider(String image) {
    print("disni" + image);
    _imgList = splitImage(image);
    print(_imgList);
    //splitAndPush(image);
    return CarouselSlider(
        //item atau image yang akan dimasukkan kedalam slider
        items: _imgList.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.network(
                    Urls.IMAGE_URL + imgUrl,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Image.asset("assets/images/no-image.png");
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ));
            },
          );
        }).toList(),

        //style pada image slider
        options: CarouselOptions(
          height: 35.0.h,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          //onPageChanged: callbackFunction,
          onPageChanged: (index, reason) {
            print(index);
            setState(() {
              _current = index;
            });
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}

//icon untuk rating
Icon iconStar(IconData icon) {
  return Icon(
    icon,
    color: Colors.yellow[600],
  );
}
