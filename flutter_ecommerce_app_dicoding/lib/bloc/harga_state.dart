part of 'harga_bloc.dart';

abstract class HargaState extends Equatable {
  const HargaState();

  @override
  List<Object> get props => [];
}

class HargaInitial extends HargaState {}

class Hargaloading extends HargaState {}

class AddSuccess extends HargaState {
  final int totalHarga;
  AddSuccess({this.totalHarga});
}

class RemoveSuccess extends HargaState {
  final int totalHarga;
  RemoveSuccess({this.totalHarga});
}

class PriceValue extends HargaState {
  final int totalHarga;
  PriceValue({this.totalHarga});

  @override
  List<Object> get props => [totalHarga];
}
