part of 'kecamatan_bloc.dart';

abstract class KecamatanEvent extends Equatable {
  const KecamatanEvent();

  @override
  List<Object> get props => [];
}

class ViewKecamatanEvent extends KecamatanEvent {
  final String kotaId;
  ViewKecamatanEvent({this.kotaId});
}
