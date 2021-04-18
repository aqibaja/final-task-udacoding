part of 'kecamatan_bloc.dart';

abstract class KecamatanState extends Equatable {
  const KecamatanState();

  @override
  List<Object> get props => [];
}

class KecamatanInitial extends KecamatanState {}

class KecamatanLoading extends KecamatanState {}

//data api login selesai di get
class KecamatanSuccess extends KecamatanState {
  final List<KecamatanModel> kecamatanModel;
  KecamatanSuccess({this.kecamatanModel});
}

class KecamatanError extends KecamatanState {
  final String error;
  KecamatanError({this.error});
}
