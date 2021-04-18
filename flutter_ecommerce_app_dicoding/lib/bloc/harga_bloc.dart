import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'harga_event.dart';
part 'harga_state.dart';

class HargaBloc extends Bloc<HargaEvent, HargaState> {
  HargaBloc() : super(HargaInitial());

  @override
  Stream<HargaState> mapEventToState(HargaEvent event) async* {
    int total;
    if (event is AddPriceEvent) {
      total = event.harga ?? 0;
      yield AddSuccess(totalHarga: total);
    } else if (event is RemovePriceEvent) {
      total = total ?? 0 - event.harga;
      yield AddSuccess(totalHarga: total);
    } else if (event is ClearEventPrice) {
      yield HargaInitial();
    }
  }
}
