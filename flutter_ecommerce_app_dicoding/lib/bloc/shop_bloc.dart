import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/ShopService.dart';
import 'package:flutter_ecommerce_app/models/MyShopModel.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial());

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is CheckShopEvent) {
      try {
        yield ShopCheckLoading();
        //Future.delayed(Duration(seconds: 2));
        MyShopModel data = await MyShopService().myShopCheck(event.idKonsumen);
        yield ShopCheckSuccess(myShopModel: data);
      } catch (e) {
        ShopError(error: e.toString());
      }
    }
    if (event is CreateShopEvent) {
      try {
        yield ShopCreateLoading();
        //Future.delayed(Duration(seconds: 2));
        MyShopModel data = await MyShopService().myShopCreate(event.idKonsumen);
        yield ShopCreateSuccess(myShopModel: data);
      } catch (e) {
        ShopError(error: e.toString());
      }
    }
    if (event is ClearShopEvent) {
      yield ShopInitial();
    }
  }
}
