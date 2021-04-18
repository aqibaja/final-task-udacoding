import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/product_bloc.dart';
import 'package:flutter_ecommerce_app/common_widget/GridTilesProducts.dart';
import 'package:flutter_ecommerce_app/common_widget/LoadingProgress.dart';
import 'package:flutter_ecommerce_app/function/splitImage.dart';
import 'package:flutter_ecommerce_app/models/PupularModel.dart';
import 'package:sizer/sizer.dart';

ProductBloc _productBloc;

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(InitialEventPopular());
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Image.asset(
            "assets/images/test_logo_ri.png",
            width: 25.0.w,
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey[300],
                height: 7.0.h,
                child: Center(
                  child: Text(
                    "Produk Baru Terpopuler",
                    style: TextStyle(
                        fontSize: 15.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(7.0.h)),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductPupularInitial) {
              _productBloc.add(ViewProductPopularEvent());
            }
            if (state is ProductPupularLoading) {
              return LoadingProgress();
            }
            if (state is ProductPupularLoaded) {
              return createListView(context, state.popularModel);
            }
            return LoadingProgress();
          },
        ));
  }
}

Widget createListView(BuildContext context, List data) {
  List<PopularModel> results = data;
  var mediaQueryData = MediaQuery.of(context);
  final double widthScreen = mediaQueryData.size.width;
  final double appBarHeight = kToolbarHeight;
  final double paddingTop = mediaQueryData.padding.top;
  final double paddingBottom = mediaQueryData.padding.bottom;
  final double heightScreen =
      (mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight) /
          1.1;

  return GridView.count(
    crossAxisCount: 2,
//    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(1.0),
    childAspectRatio: widthScreen / heightScreen,

    children: List<Widget>.generate(results.length, (index) {
      List<String> _image = [];
      _image = splitImage(results[index].gambar);
      print(results[index].rating);
      print(results[index].diskon);
      return GridTile(
          child: GridTilesProducts(
        name: results[index].namaProduk,
        imageUrl: _image,
        slug: results[index].id.toString(),
        price: results[index].hargaKonsumen.toString(),
        priceDiscount: results[index].fixHarga.toString(),
        rating: results[index].rating.toString(),
      ));
    }),
  );
}
