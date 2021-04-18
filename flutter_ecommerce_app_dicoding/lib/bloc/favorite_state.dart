part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

//data api login selesai di get
class FavoriteSuccess extends FavoriteState {
  final List<FavoriteModel> favoriteModel;
  FavoriteSuccess({this.favoriteModel});
}

class FavoriteZonk extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;
  FavoriteError({this.error});
}

class FavoriteAddInitial extends FavoriteState {}

class FavoriteAddLoading extends FavoriteState {}

//data api login selesai di get
class FavoriteAddSuccess extends FavoriteState {
  final AddDeleteFavoriteModel addFavoriteModel;
  FavoriteAddSuccess({this.addFavoriteModel});
}

class FavoriteAddError extends FavoriteState {
  final String error;
  FavoriteAddError({this.error});
}

class FavoriteDeleteInitial extends FavoriteState {}

class FavoriteDeleteLoading extends FavoriteState {}

//data api login selesai di get
class FavoriteDeleteSuccess extends FavoriteState {
  final AddDeleteFavoriteModel deleteFavoriteModel;
  FavoriteDeleteSuccess({this.deleteFavoriteModel});
}

class FavoriteDeleteError extends FavoriteState {
  final String error;
  FavoriteDeleteError({this.error});
}
