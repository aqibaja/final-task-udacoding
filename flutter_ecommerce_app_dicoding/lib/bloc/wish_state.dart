part of 'wish_bloc.dart';

abstract class WishState extends Equatable {
  const WishState();

  @override
  List<Object> get props => [];
}

class WishInitial extends WishState {}

class FavoriteListInitial extends WishState {}

class FavoriteListLoading extends WishState {}

//data api login selesai di get
class FavoriteListSuccess extends WishState {
  final List<ListFavoriteModel> listFavoriteModel;
  FavoriteListSuccess({this.listFavoriteModel});
}

class FavoriteListFail extends WishState {}

class FavoriteListError extends WishState {
  final String error;
  FavoriteListError({this.error});
}
