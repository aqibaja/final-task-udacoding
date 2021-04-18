part of 'wish_bloc.dart';

abstract class WishEvent extends Equatable {
  const WishEvent();

  @override
  List<Object> get props => [];
}

class ListFavoriteEvent extends WishEvent {
  final String konsumenId;
  ListFavoriteEvent({this.konsumenId});
}

class ClearEventWish extends WishEvent {}
