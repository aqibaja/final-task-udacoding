import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/FavoriteService.dart';
import 'package:flutter_ecommerce_app/models/listFavorite.dart';

part 'wish_event.dart';
part 'wish_state.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc() : super(WishInitial());

  @override
  Stream<WishState> mapEventToState(WishEvent event) async* {
    if (event is ListFavoriteEvent) {
      try {
        yield FavoriteListLoading();
        //Future.delayed(Duration(seconds: 2));
        var data = await FavoriteService().listFavorite(event.konsumenId);
        if (data == 400) {
          print("list zonk!!!");
          yield FavoriteListFail();
        } else {
          yield FavoriteListSuccess(listFavoriteModel: data);
        }
      } catch (e) {
        print("List error => " + e.toString());
        FavoriteListError(error: e.toString());
      }
    }
    //clear state
    else if (event is ClearEventWish) {
      yield WishInitial();
    }
  }
}
