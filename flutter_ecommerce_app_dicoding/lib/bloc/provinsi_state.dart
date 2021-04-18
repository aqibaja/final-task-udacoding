part of 'provinsi_bloc.dart';

abstract class ProvinsiState extends Equatable {
  const ProvinsiState();

  @override
  List<Object> get props => [];
}

class AlamatInitial extends ProvinsiState {}

class ProvinsiLoading extends ProvinsiState {}

class ProvinsiError extends ProvinsiState {
  final String error;
  ProvinsiError({this.error});
}

//data api login selesai di get
class ProvinsiSuccess extends ProvinsiState {
  final List<ProvinsiModel> provinsiModel;
  ProvinsiSuccess({this.provinsiModel});
}
