import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/components/BrandHomePage.dart';
import 'package:flutter_ecommerce_app/components/CategorySlider.dart';
import 'package:flutter_ecommerce_app/common_widget/PopularMenu.dart';
import 'package:flutter_ecommerce_app/common_widget/SearchWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/TopPromoSlider.dart';
import 'package:flutter_ecommerce_app/components/ShopHomePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SearchWidget(),
          TopPromoSlider(),
          PopularMenu(),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Categories',
                ),
                Tab(
                  text: 'Shops',
                )
              ], // list of tabs
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.white24,
                  child: CategoryPage(slug: 'kategori/'),
                ),
                Container(
                  color: Colors.white24,
                  child: ShopHomePage(
                    slug: 'shop/',
                  ),
                ) // class name
              ],
            ),
          ),
        ],
      ),
    );
  }
}
