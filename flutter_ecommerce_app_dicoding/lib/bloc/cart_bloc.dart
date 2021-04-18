import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/CartService.dart';
import 'package:flutter_ecommerce_app/models/addDeleteCartModel.dart';
import 'package:flutter_ecommerce_app/models/listCart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is ListCartEvent) {
      try {
        yield CartListLoading();
        //Future.delayed(Duration(seconds: 2));
        var data = await CartService().listCart(event.konsumenId);
        if (data == 400) {
          print("list zonk!!!");
          yield CartListFail();
        } else {
          yield CartListSuccess(listCartModel: data);
        }
      } catch (e) {
        print("List Cart error => " + e.toString());
        CartListError(error: e.toString());
      }
    } else if (event is AddCartEvent) {
      try {
        yield CartAddLoading();
        //Future.delayed(Duration(seconds: 2));
        AddDeleteCartModel data =
            await CartService().addCart(event.konsumenId, event.productId);
        print("Done Add to cart");
        yield CartAddSuccess(addCartModel: data);
      } catch (e) {
        print(e.toString());
        yield CartAddError(error: e.toString());
      }
    } else if (event is AddTotalCartEvent) {
      try {
        yield CartAddTotalLoading();
        //Future.delayed(Duration(seconds: 2));
        AddDeleteCartModel data =
            await CartService().addTotalCart(event.konsumenId, event.productId);
        yield CartAddTotalSuccess(addCartModel: data);
      } catch (e) {
        print(e.toString());
        yield CartAddTotalError(error: e.toString());
      }
    } else if (event is DeleteCartEvent) {
      try {
        yield CartDeleteLoading();
        //Future.delayed(Duration(seconds: 2));
        AddDeleteCartModel data =
            await CartService().deleteCart(event.konsumenId, event.productId);

        yield CartDeleteSuccess(deleteCartModel: data);
      } catch (e) {
        CartDeleteError(error: e.toString());
      }
    }
    //clear state
    else if (event is ClearEventCart) {
      yield CartInitial();
    }
  }
}
