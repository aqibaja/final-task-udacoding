part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class CheckFavoriteEvent extends FavoriteEvent {
  final String konsumenId;
  final String productId;
  CheckFavoriteEvent({this.konsumenId, this.productId});
}

class AddFavoriteEvent extends FavoriteEvent {
  final String konsumenId;
  final String productId;
  AddFavoriteEvent({this.konsumenId, this.productId});
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final String konsumenId;
  final String productId;
  DeleteFavoriteEvent({this.konsumenId, this.productId});
}

class ClearEventFavorite extends FavoriteEvent {}
