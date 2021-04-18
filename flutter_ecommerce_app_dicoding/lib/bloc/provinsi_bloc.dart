import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/DetailAlamatService.dart';
import 'package:flutter_ecommerce_app/models/KecamatanModel.dart';
import 'package:flutter_ecommerce_app/models/KotaModel.dart';
import 'package:flutter_ecommerce_app/models/provinsiModel.dart';

part 'provinsi_event.dart';
part 'provinsi_state.dart';

class ProvinsiBloc extends Bloc<ProvinsiEvent, ProvinsiState> {
  ProvinsiBloc() : super(AlamatInitial());

  @override
  Stream<ProvinsiState> mapEventToState(
    ProvinsiEvent event,
  ) async* {
    if (event is ViewProvinsiEvent) {
      try {
        yield ProvinsiLoading();
        //Future.delayed(Duration(seconds: 2));
        List<ProvinsiModel> data = await AlamatService().getDetailProvinsi();
        yield ProvinsiSuccess(provinsiModel: data);
      } catch (e) {
        ProvinsiError(error: e.toString());
      }
    }
    if (event is ClearEventProvinsi) {
      yield AlamatInitial();
    }
  }
}
