import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/DetailAlamatService.dart';
import 'package:flutter_ecommerce_app/models/KecamatanModel.dart';

part 'kecamatan_event.dart';
part 'kecamatan_state.dart';

class KecamatanBloc extends Bloc<KecamatanEvent, KecamatanState> {
  KecamatanBloc() : super(KecamatanInitial());

  @override
  Stream<KecamatanState> mapEventToState(
    KecamatanEvent event,
  ) async* {
    if (event is ViewKecamatanEvent) {
      try {
        yield KecamatanLoading();
        //Future.delayed(Duration(seconds: 2));
        List<KecamatanModel> data =
            await AlamatService().getDetailKecamatan(event.kotaId);
        yield KecamatanSuccess(kecamatanModel: data);
      } catch (e) {
        KecamatanError(error: e.toString());
      }
    }
  }
}
