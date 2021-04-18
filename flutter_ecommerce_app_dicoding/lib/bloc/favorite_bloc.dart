import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/FavoriteService.dart';
import 'package:flutter_ecommerce_app/models/FavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/addDeleteFavoriteModel.dart';
import 'package:flutter_ecommerce_app/models/listFavorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is CheckFavoriteEvent) {
      try {
        yield FavoriteLoading();
        //Future.delayed(Duration(seconds: 2));
        List<FavoriteModel> data = await FavoriteService()
            .getDetailFavorite(event.konsumenId, event.productId);
        if (data != null) {
          yield FavoriteSuccess(favoriteModel: data);
        } else {
          yield FavoriteZonk();
        }
      } catch (e) {
        FavoriteError(error: e.toString());
      }
    } else if (event is AddFavoriteEvent) {
      try {
        yield FavoriteAddLoading();
        //Future.delayed(Duration(seconds: 2));
        AddDeleteFavoriteModel data = await FavoriteService()
            .addFavorite(event.konsumenId, event.productId);
        yield FavoriteAddSuccess(addFavoriteModel: data);
      } catch (e) {
        print(e.toString());
        yield FavoriteAddError(error: e.toString());
      }
    } else if (event is DeleteFavoriteEvent) {
      try {
        yield FavoriteDeleteLoading();
        //Future.delayed(Duration(seconds: 2));
        AddDeleteFavoriteModel data = await FavoriteService()
            .deleteFavorite(event.konsumenId, event.productId);
        yield FavoriteDeleteSuccess(deleteFavoriteModel: data);
      } catch (e) {
        FavoriteDeleteError(error: e.toString());
      }
    }
    //clear state
    else if (event is ClearEventFavorite) {
      yield FavoriteInitial();
    }
  }
}
