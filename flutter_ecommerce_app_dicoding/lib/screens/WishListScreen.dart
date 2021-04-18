import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/favorite_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/wish_bloc.dart';
import 'package:flutter_ecommerce_app/components/AppSignIn.dart';
import 'package:flutter_ecommerce_app/function/splitImage.dart';
import 'package:flutter_ecommerce_app/models/listFavorite.dart';
import 'package:flutter_ecommerce_app/screens/ProductDetailScreen.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return EmptyWishListScreen();
  }
}

class EmptyWishListScreen extends StatefulWidget {
  @override
  _EmptyWishListScreenState createState() => _EmptyWishListScreenState();
}

AuthBloc _authBloc;
WishBloc _wishBloc;
FavoriteBloc _favoriteBloc;

class _EmptyWishListScreenState extends State<EmptyWishListScreen> {
  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _wishBloc = BlocProvider.of<WishBloc>(context);
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    String konsumenId;
    return SafeArea(child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          _authBloc.add(CheckLoginEvent());
        }
        if (state is SignInOut) {
          print("belum login");
          return Center(
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AppSignIn())),
                child: Text("LOGIN")),
          );
          /*  Future.delayed(Duration(milliseconds: 700), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AppSignIn()));
          }); */
        }
        if (state is SignInSaved) {
          konsumenId = state.idUSerSave;
          print("tersimpan!!!");
          _wishBloc.add(ClearEventWish());
          return BlocBuilder<WishBloc, WishState>(
            builder: (context, state) {
              if (state is WishInitial) {
                _wishBloc.add(ListFavoriteEvent(konsumenId: konsumenId));
              }
              if (state is FavoriteListLoading) {
                print("favorite list loading");
                EasyLoading.show(status: 'loading...');
              }
              if (state is FavoriteListSuccess) {
                _favoriteBloc.add(ClearEventFavorite());
                print("list loadeedd!!");
                EasyLoading.dismiss();
                List<ListFavoriteModel> data = state.listFavoriteModel;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      List image = splitImage(data[i].gambar);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    Urls.PRODUCT_IMAGE_URL + image[0]),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[i].namaProduk,
                                      style: TextStyle(fontSize: 25),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Rp. " + data[i].fixHarga.toString(),
                                      style: TextStyle(fontSize: 25),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ProductDetailScreen(
                                                                slug: data[i]
                                                                    .idProduk
                                                                    .toString(),
                                                                rating: "0")));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.green, // background
                                                onPrimary:
                                                    Colors.white, // foreground
                                              ),
                                              child: Text("Detail")),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        BlocBuilder<FavoriteBloc,
                                            FavoriteState>(
                                          builder: (context, state) {
                                            if (state
                                                is FavoriteDeleteLoading) {
                                              print("delete loading!!!");
                                              EasyLoading.show(
                                                  status: 'loading...');
                                            }
                                            if (state
                                                is FavoriteDeleteSuccess) {
                                              EasyLoading.dismiss();
                                              _wishBloc.add(ListFavoriteEvent(
                                                  konsumenId: konsumenId));
                                            }
                                            return Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    _favoriteBloc.add(
                                                        DeleteFavoriteEvent(
                                                            konsumenId:
                                                                konsumenId,
                                                            productId: data[i]
                                                                .id
                                                                .toString()));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .red, // background
                                                    onPrimary: Colors
                                                        .white, // foreground
                                                  ),
                                                  child: Text("Hapus")),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              if (state is FavoriteListFail) {
                EasyLoading.dismiss();
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 250,
                          child: Image.asset(
                            "assets/images/empty_wish_list-2.png",
                            height: 250,
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Kamu tidak memiliki apapun didalam daftar keinginan",
                            style: TextStyle(
                              color: Color(0xFF67778E),
                              fontFamily: 'Roboto-Light.ttf',
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          );
        }
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                  child: Container(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    "assets/images/empty_wish_list-2.png",
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Kamu tidak memiliki apapun didalam daftar keinginan",
                    style: TextStyle(
                      color: Color(0xFF67778E),
                      fontFamily: 'Roboto-Light.ttf',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
