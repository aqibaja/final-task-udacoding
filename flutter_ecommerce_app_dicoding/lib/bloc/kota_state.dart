part of 'kota_bloc.dart';

abstract class KotaState extends Equatable {
  const KotaState();

  @override
  List<Object> get props => [];
}

class KotaInitial extends KotaState {}

class KotaLoading extends KotaState {}

//data api login selesai di get
class KotaSuccess extends KotaState {
  final List<KotaModel> kotaModel;
  KotaSuccess({this.kotaModel});
}

class KotaError extends KotaState {
  final String error;
  KotaError({this.error});
}
