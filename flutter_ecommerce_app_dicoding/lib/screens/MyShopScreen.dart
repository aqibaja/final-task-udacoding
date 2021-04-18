import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/shop_bloc.dart';
import 'package:flutter_ecommerce_app/components/AppSignIn.dart';
import 'package:flutter_ecommerce_app/components/AppSingUp.dart';
import 'package:flutter_ecommerce_app/models/MyShopModel.dart';

class MyShopScreen extends StatefulWidget {
  @override
  _MyShopScreenState createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  ShopBloc _blocShop;
  AuthBloc _blocAuth;
  String idKonsumen;
  @override
  Widget build(BuildContext context) {
    _blocShop = BlocProvider.of<ShopBloc>(context);
    _blocAuth = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Shop"),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              _blocAuth.add(CheckLoginEvent());
            }
            if (state is SignUpLoading) {
              print("loading!!!!!!!!!!!!!!");
              return Container();
              //EasyLoading.show(status: 'loading...');
            }
            if (state is SignInSaved) {
              idKonsumen = state.idUSerSave;
              return Center(child: BlocBuilder<ShopBloc, ShopState>(
                builder: (context, state) {
                  if (state is ShopInitial) {
                    _blocShop.add(CheckShopEvent(idKonsumen: idKonsumen));
                  }
                  if (state is ShopCheckLoading) {
                    print("loading Shop Check !!!!");
                    EasyLoading.show(status: 'loading...');
                  }
                  if (state is ShopCheckSuccess) {
                    MyShopModel myShop = state.myShopModel;
                    print(myShop.message);
                    EasyLoading.dismiss();
                    if (myShop.success == "true") {
                      return listView("", "", "", "", "", "", "");
                    } else {
                      return ElevatedButton(
                          onPressed: () {
                            _blocShop
                                .add(CreateShopEvent(idKonsumen: idKonsumen));
                          },
                          child: Text("Buat Toko"));
                    }
                  }
                  if (state is ShopCreateLoading) {
                    print("loading Shop create !!!!");
                    EasyLoading.show(status: 'loading...');
                  }
                  if (state is ShopCreateSuccess) {
                    MyShopModel myShop = state.myShopModel;
                    print(myShop.message);
                    EasyLoading.dismiss();
                    return listView("", "", "", "", "", "", "");
                  }
                  return Container();
                },
              ));
            }
            if (state is SignInOut) {
              return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AppSignIn()));
                  },
                  child: Text("LOGIN"));
            }
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AppSignIn()));
                },
                child: Text("LOGIN"));
          },
        ));
  }

  Widget listView(String name, String username, String uAvatarUrl, String id,
      String email, String bio, String website) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 13, top: 25, right: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 46.1,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: uAvatarUrl == null || uAvatarUrl == ""
                      ? AssetImage('assets/images/avatar.png')
                      : NetworkImage(uAvatarUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              columnText('0', 'Post'),
              columnText('0', 'Followers'),
              columnText('0', 'Following'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 13, top: 13, right: 13),
          child: Text(
            name ?? username,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        (website != null)
            ? Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Text(
                  website,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Text(
            bio ?? "",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                /* => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditScreen(
                              name: name,
                              bio: bio,
                              username: username,
                              uAvatarUrl: uAvatarUrl,
                              uid: id,
                              website: website,
                            ))), */
                child: Text("Edit Toko", style: TextStyle(fontSize: 19)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              )),
            ],
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          child: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on_outlined),
              ),
              Tab(
                icon: Icon(
                  Icons.assignment_ind_rounded,
                ),
              )
            ], // list of tabs
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: double.maxFinite,
          child: TabBarView(
            children: [
              Container(color: Colors.white24, child: allPost()),
              Container(color: Colors.white24, child: Container()) // class name
            ],
          ),
        ),
      ],
    );
  }

  Container allPost() {
    List feed = [];
    return Container(
      width: double.infinity,
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: feed.length,
          itemBuilder: (BuildContext context, i) {
            return i == 1
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        child: Column(
                      children: [Icon(Icons.add), Text("Tambah")],
                    )),
                  )
                : itemGrid(
                    feed[i].username,
                    feed[i].uid,
                    feed[i].uavatarUrl,
                    feed[i].imageUrl,
                    feed[i].desc,
                  );
          }),
    );
  }

  Widget itemGrid(username, uid, uavatarUrl, imageUrl, desc) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Column columnText(String count, String type) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 25),
        ),
        Text(
          type,
          style: TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
