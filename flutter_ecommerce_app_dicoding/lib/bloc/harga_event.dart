part of 'harga_bloc.dart';

abstract class HargaEvent extends Equatable {
  const HargaEvent();

  @override
  List<Object> get props => [];
}

class AddPriceEvent extends HargaEvent {
  final int harga;
  AddPriceEvent({this.harga});
}

class RemovePriceEvent extends HargaEvent {
  final int harga;
  RemovePriceEvent({this.harga});
}

class ClearEventPrice extends HargaEvent {}
