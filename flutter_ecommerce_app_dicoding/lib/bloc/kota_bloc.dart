import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/DetailAlamatService.dart';
import 'package:flutter_ecommerce_app/models/KotaModel.dart';

part 'kota_event.dart';
part 'kota_state.dart';

class KotaBloc extends Bloc<KotaEvent, KotaState> {
  KotaBloc() : super(KotaInitial());

  @override
  Stream<KotaState> mapEventToState(
    KotaEvent event,
  ) async* {
    if (event is ViewKotaEvent) {
      try {
        yield KotaLoading();
        //Future.delayed(Duration(seconds: 2));
        List<KotaModel> data =
            await AlamatService().getDetailKota(event.provinsiId);
        yield KotaSuccess(kotaModel: data);
      } catch (e) {
        KotaError(error: e.toString());
      }
    }
    if (event is ClearEventKota) {
      yield KotaInitial();
    }
  }
}
