part of 'provinsi_bloc.dart';

abstract class ProvinsiEvent extends Equatable {
  const ProvinsiEvent();

  @override
  List<Object> get props => [];
}

class ViewProvinsiEvent extends ProvinsiEvent {}

class ClearEventProvinsi extends ProvinsiEvent {}
