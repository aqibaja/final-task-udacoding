part of 'konsumen_bloc.dart';

abstract class KonsumenState extends Equatable {
  const KonsumenState();

  @override
  List<Object> get props => [];
}

class KonsumenInitial extends KonsumenState {}

//data api konsumen selesai di get
class KonsumenSuccess extends KonsumenState {
  final DetailKonsumenModel konsumenModel;
  KonsumenSuccess({this.konsumenModel});
}

class KonsumenFail extends KonsumenState {
  final KonsumenFailModel konsumenModel;
  KonsumenFail({this.konsumenModel});
}

class KonsumenLoading extends KonsumenState {}

class KonsumenError extends KonsumenState {
  final String error;
  KonsumenError({this.error});
}

//data api edit konsumen selesai di get
class KonsumenEditSuccess extends KonsumenState {
  final EditKonsumenModel konsumenEditModel;
  KonsumenEditSuccess({this.konsumenEditModel});
}

class KonsumenEditFail extends KonsumenState {
  final KonsumenFailModel konsumenEditModel;
  KonsumenEditFail({this.konsumenEditModel});
}

class KonsumenEditLoading extends KonsumenState {}

class KonsumenEditError extends KonsumenState {
  final String error;
  KonsumenEditError({this.error});
}
