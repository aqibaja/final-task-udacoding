import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/cart_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/favorite_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/harga_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/kota_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/product_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/provinsi_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/konsumen_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/shop_bloc.dart';
import 'package:flutter_ecommerce_app/common_widget/AppBarWidget.dart';
//import 'package:flutter_ecommerce_app/common_widget/BottomNavBarWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/DrawerWidget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/screens/HomeScreen.dart';
import 'package:flutter_ecommerce_app/screens/MyShopScreen.dart';
import 'package:flutter_ecommerce_app/screens/ProfileScreen.dart';
import 'package:flutter_ecommerce_app/screens/ShopScreen.dart';
import 'package:flutter_ecommerce_app/screens/ShoppingCartScreen.dart';
import 'package:flutter_ecommerce_app/screens/WishListScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/kecamatan_bloc.dart';
import 'bloc/wish_bloc.dart';
import 'components/AppSignIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil().init(constraints, orientation);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => KonsumenBloc(),
            ),
            BlocProvider(
              create: (context) => ProvinsiBloc(),
            ),
            BlocProvider(
              create: (context) => KotaBloc(),
            ),
            BlocProvider(
              create: (context) => KecamatanBloc(),
            ),
            BlocProvider(create: (context) => ProductBloc()),
            BlocProvider(create: (context) => FavoriteBloc()),
            BlocProvider(create: (context) => ShopBloc()),
            BlocProvider(create: (context) => WishBloc()),
            BlocProvider(create: (context) => CartBloc()),
            BlocProvider(create: (context) => HargaBloc()),
          ],
          child: MaterialApp(
            title: "Rumah Indonesia",
            home: MyHomePage(),
            theme: ThemeData(
                fontFamily: 'Roboto',
                primaryColor: Colors.white,
                primaryColorDark: Colors.white,
                backgroundColor: Colors.white),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            builder: EasyLoading.init(),
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/home': (context) => MyHomePage(),
              '/profile': (context) => ProfileScreen(),
            },
          ),
        );
      });
    });
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

AuthBloc _authBloc;

class _MyHomePageNewState extends State<MyHomePage> {
  final List<Widget> viewContainer = [
    HomeScreen(),
    ShopScreen(),
    WishListScreen(),
    ShoppingCartScreen(),
    /* MyShopScreen() */
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    return DefaultTabController(
        length: 2,
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          print("auth = " + state.toString());
          if (state is AuthInitial) {
            EasyLoading.show(status: 'loading...');

            _authBloc.add(CheckLoginEvent());
          }
          if (state is SignInOut) {
            print("belum login");
            EasyLoading.dismiss();
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
            String konsumenId = state.idUSerSave;
            print("konsumenID = " + konsumenId);
            print("id konsumen di cart tersimpan!!!");
            EasyLoading.dismiss();
          }
          return Scaffold(
              resizeToAvoidBottomInset:
                  false, //agar ketika keyboard naik tidak ada yg terangkat
              appBar: appBarWidget(context),
              drawer: DrawerWidget(),
              body: IndexedStack(
                index: currentIndex,
                children: viewContainer,
              ),
              bottomNavigationBar: buildBottomNavigationBar());
        }));
  }

  //bar dibawah
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(color: Color(0xFF545454)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text(
            'Shop',
            style: TextStyle(color: Color(0xFF545454)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.heart),
          title: Text(
            'Wish List',
            style: TextStyle(color: Color(0xFF545454)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.shoppingBag),
          title: Text(
            'Cart',
            style: TextStyle(color: Color(0xFF545454)),
          ),
        ),
        /* BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.shopify),
          title: Text(
            'My Shop',
            style: TextStyle(color: Color(0xFF545454)),
          ),
        ), */
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFFAA292E),
      onTap: _onItemTapped,
    );
  }
}
