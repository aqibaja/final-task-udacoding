import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/harga_bloc.dart';
import 'package:flutter_ecommerce_app/components/AppSignIn.dart';
import 'package:flutter_ecommerce_app/function/splitImage.dart';
import 'package:flutter_ecommerce_app/models/listCart.dart';
import 'package:flutter_ecommerce_app/screens/ProductDetailScreen.dart';
import 'package:flutter_ecommerce_app/utils/Constants.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return EmptyShoppingCartScreen();
  }
}

class EmptyShoppingCartScreen extends StatefulWidget {
  @override
  _EmptyShoppingCartScreenState createState() =>
      _EmptyShoppingCartScreenState();
}

AuthBloc _authBloc;
CartBloc _cartBloc;
HargaBloc _hargaBloc;

class _EmptyShoppingCartScreenState extends State<EmptyShoppingCartScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getNotifikasiCart() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.subscribeToTopic("topicsMentoring");
    _firebaseMessaging.configure(
        // ketika didalam aplikasi
        onMessage: (Map<String, dynamic> message) async {
          String title = "${message['notification']['title']}";
          print(title);
          if (title == "delete") {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: "${message['notification']['body']}",
              ),
            );
          } else if (title == "tambah") {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "${message['notification']['body']}",
              ),
            );
          }
        },
        //ketika app tertutup
        onLaunch: (Map<String, dynamic> message) async {},

        //ketika app berjalan di background
        onResume: (Map<String, dynamic> message) async {});
  }

  void sendNotifikasiDelete() async {
    final body = jsonEncode({
      "to": "/topics/topicsMentoring",
      "topic": "topicsMentoring",
      "notification": {
        "title": "delete",
        "body": "Success Delete Product",
        "sound": "default"
      }
    });
    await http.post(BaseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: keyMassaging
        },
        body: body);
  }

  void sendNotifikasiAdd() async {
    final body = jsonEncode({
      "to": "/topics/topicsMentoring",
      "topic": "topicsMentoring",
      "notification": {
        "title": "tambah",
        "body": "Success Tambah Product",
        "sound": "default"
      }
    });
    await http.post(BaseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: keyMassaging
        },
        body: body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifikasiCart();
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _hargaBloc = BlocProvider.of<HargaBloc>(context);
    String konsumenId = context.select<AuthBloc, String>((authBloc) =>
        (authBloc.state is SignInSaved)
            ? (authBloc.state as SignInSaved).idUSerSave
            : null);
    int totalPrice = context.select<HargaBloc, int>((hargaBloc) =>
        (hargaBloc.state is AddSuccess)
            ? (hargaBloc.state as AddSuccess).totalHarga
            : null);
    List<ListCartModel> CartModel =
        context.select<CartBloc, List<ListCartModel>>((cartBloc) =>
            (cartBloc.state is CartListSuccess)
                ? (cartBloc.state as CartListSuccess).listCartModel
                : null);
    if (konsumenId != null) {
      print("id konsumen di cart tersimpan!!! = " + konsumenId);
      //_cartBloc.add(ClearEventCart());
      return Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              print("Cart state = " + state.toString());
              if (state is CartInitial) {
                _cartBloc.add(ListCartEvent(konsumenId: konsumenId));
              }
              if (state is CartListLoading) {
                print("Cart list loading");
                EasyLoading.show(status: 'loading...');
              }
              if (state is CartAddTotalLoading) {
                print("Cart list loading");
                EasyLoading.show(status: 'loading...');
              }
              if (state is CartAddTotalSuccess) {
                print("add sukses");
                sendNotifikasiAdd();
                EasyLoading.dismiss();
                _hargaBloc.add(ClearEventPrice());
                _cartBloc.add(ListCartEvent(konsumenId: konsumenId));
              }
              if (state is CartDeleteLoading) {
                print("Cart list remove loading");
                EasyLoading.show(status: 'loading...');
              }
              if (state is CartDeleteSuccess) {
                print("remove sukses");
                sendNotifikasiDelete();
                EasyLoading.dismiss();
                _hargaBloc.add(ClearEventPrice());
                _cartBloc.add(ListCartEvent(konsumenId: konsumenId));
              }
              if (state is CartListSuccess) {
                int totalHarga = 0;
                print("list cart loadeedd!!");
                EasyLoading.dismiss();
                List<ListCartModel> data = state.listCartModel;
                for (int i = 0; i < data.length; i++) {
                  int total = data[i].fixHarga * data[i].total;
                  totalHarga = totalHarga + total;
                  print("ke-" + i.toString() + " " + total.toString());
                  print(totalHarga);
                }
                print("total harga " + totalHarga.toString());
                _hargaBloc.add(AddPriceEvent(harga: totalHarga));
                return Container(
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          List image = splitImage(data[i].gambar);
                          int total = data[i].total;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[i].namaProduk,
                                          style: TextStyle(fontSize: 25),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${formatCurrency.format(data[i].fixHarga)}",
                                              style: TextStyle(fontSize: 25),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "x",
                                              style: TextStyle(fontSize: 25),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              total.toString(),
                                              style: TextStyle(fontSize: 25),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    _cartBloc.add(
                                                        AddTotalCartEvent(
                                                            konsumenId:
                                                                konsumenId,
                                                            productId: data[i]
                                                                .idProduk
                                                                .toString()));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .green, // background
                                                    onPrimary: Colors
                                                        .white, // foreground
                                                  ),
                                                  child: Text("Tambah")),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            BlocBuilder<CartBloc, CartState>(
                                              builder: (context, state) {
                                                if (state
                                                    is CartDeleteLoading) {
                                                  print("delete loading!!!");
                                                  EasyLoading.show(
                                                      status: 'loading...');
                                                }
                                                if (state
                                                    is CartDeleteSuccess) {
                                                  EasyLoading.dismiss();
                                                  _cartBloc.add(ListCartEvent(
                                                      konsumenId: konsumenId));
                                                }
                                                return Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        _cartBloc.add(
                                                            DeleteCartEvent(
                                                                konsumenId:
                                                                    konsumenId,
                                                                productId: data[
                                                                        i]
                                                                    .id
                                                                    .toString()));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
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
                        }),
                  ),
                );
              }
              if (state is CartListFail) {
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
              return Expanded(
                child: Container(
                  height: double.infinity,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Total :",
                    style: TextStyle(fontSize: 35),
                  ),
                  Spacer(),
                  Text(
                    (totalPrice == null)
                        ? ""
                        : "${formatCurrency.format(totalPrice)}",
                    style: TextStyle(fontSize: 35),
                  )
                  /*  BlocBuilder<HargaBloc, HargaState>(
                        builder: (context, state) {
                          if (state is AddSuccess) {
                            return Text(
                              "${formatCurrency.format(state.totalHarga)}",
                              style: TextStyle(fontSize: 35),
                            );
                          }
                          return Text(
                            "${formatCurrency.format(0)}",
                            style: TextStyle(fontSize: 35),
                          );
                        },
                      ) */
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Bayar",
                  style: TextStyle(fontSize: 35),
                )),
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
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
                "assets/images/empty_shopping_cart-2.png",
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
                "Kamu tidak memiliki apapun didalam keranjang",
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
      );
    }
  }
}
