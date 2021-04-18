part of 'kota_bloc.dart';

abstract class KotaEvent extends Equatable {
  const KotaEvent();

  @override
  List<Object> get props => [];
}

class ViewKotaEvent extends KotaEvent {
  final String provinsiId;
  ViewKotaEvent({this.provinsiId});
}

class ClearEventKota extends KotaEvent {}
