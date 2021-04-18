import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/PoductService.dart';
import 'package:flutter_ecommerce_app/models/DiscountModel.dart';
import 'package:flutter_ecommerce_app/models/ProductsModel.dart';
import 'package:flutter_ecommerce_app/models/PupularModel.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ViewProductPopularEvent) {
      try {
        yield ProductPupularLoading();
        //Future.delayed(Duration(seconds: 2));
        List<PopularModel> data = await ProductService().getDetailPopular();
        yield ProductPupularLoaded(popularModel: data);
      } catch (e) {
        ProductPupularError(error: e.toString());
      }
    }
    if (event is ViewProductDiscountEvent) {
      try {
        yield ProductDiscountLoading();
        //Future.delayed(Duration(seconds: 2));
        List<DiscountModel> data = await ProductService().getDetailDiscount();
        yield ProductDiscountLoaded(discountModel: data);
      } catch (e) {
        ProductDiscountError(error: e.toString());
      }
    }
    if (event is ViewProductDetailEvent) {
      try {
        yield ProductDetailLoading();
        //Future.delayed(Duration(seconds: 2));
        List<ProductModels> data =
            await ProductService().getDetailProduct(event.productId);
        yield ProductDetailLoaded(productModel: data);
      } catch (e) {
        ProductDetailError(error: e.toString());
      }
    }
    if (event is InitialEventPopular) {
      yield ProductPupularInitial();
    }
    if (event is InitialEventDiscount) {
      yield ProductDiscountInitial();
    }

    if (event is InitialEventDetailProduct) {
      yield ProductDetailInitial();
    }
  }
}
