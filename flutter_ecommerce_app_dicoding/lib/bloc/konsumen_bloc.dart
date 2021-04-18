import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/API_services/EditKonsumenService.dart';
import 'package:flutter_ecommerce_app/API_services/KonsumenService.dart';
import 'package:flutter_ecommerce_app/models/DetailKonsumenModel.dart';
import 'package:flutter_ecommerce_app/models/EditKonsumenModel.dart';
import 'package:flutter_ecommerce_app/models/KonsumenFailModel.dart';

part 'konsumen_event.dart';
part 'konsumen_state.dart';

class KonsumenBloc extends Bloc<KonsumenEvent, KonsumenState> {
  KonsumenBloc() : super(KonsumenInitial());

  @override
  Stream<KonsumenState> mapEventToState(KonsumenEvent event) async* {
    if (event is ViewDetailEvent) {
      try {
        yield KonsumenLoading();
        //Future.delayed(Duration(seconds: 30));
        DetailKonsumenModel data =
            await KonsumenService().getDetailData(event.idKonsumen);
        if (data.success == "true") {
          yield KonsumenSuccess(konsumenModel: data);
        }
        //yield KonsumenFail(konsumenModel: data);
      } catch (e) {
        KonsumenError(error: e.toString());
      }
    } else if (event is EditDetailEvent) {
      try {
        yield KonsumenEditLoading();
        //Future.delayed(Duration(seconds: 2));
        EditKonsumenModel data = await KonsumenEditService().getDetailData(
            event.idKonsumen,
            event.username,
            event.password,
            event.namaLengkap,
            event.email,
            event.jenisKelamin,
            event.tanggalLahir,
            event.tempatLahir,
            event.alamatLengkap,
            event.kecamatanId,
            event.kotaId,
            event.provinsiId,
            event.noHp,
            event.foto);
        if (data.success == "true") {
          yield KonsumenEditSuccess(konsumenEditModel: data);
        }
        //yield KonsumenFail(konsumenModel: data);
      } catch (e) {
        KonsumenEditError(error: e.toString());
      }
      if (event is ClearEventKonsumen) {
        yield KonsumenInitial();
      }
    }
  }
}
