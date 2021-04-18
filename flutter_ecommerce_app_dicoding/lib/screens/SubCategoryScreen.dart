import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/common_widget/AppBarWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/BottomNavBarWidget.dart';
import 'package:flutter_ecommerce_app/common_widget/SearchWidget.dart';
import 'package:flutter_ecommerce_app/components/subCategorySlider.dart';

class SubCategoryScreen extends StatelessWidget {
  final String slug;
  final IconData icon; //icon from category

  SubCategoryScreen({Key key, @required this.slug, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        body: SafeArea(
          child: Column(
            children: [
              SearchWidget(),
              SizedBox(
                height: 5,
                child: Container(
                  color: Color(0xFFf5f6f7),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFf5f6f7),
                  child: SubCategoryPage(
                    slug: slug,
                    icon: icon,
                  ),
                ),
              ),
            ],
          ),
        ),
        /* bottomNavigationBar: BottomNavBarWidget(), */
      ),
    );
  }
}
