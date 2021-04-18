part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class CheckShopEvent extends ShopEvent {
  final String idKonsumen;
  CheckShopEvent({this.idKonsumen});
}

class CreateShopEvent extends ShopEvent {
  final String idKonsumen;
  CreateShopEvent({this.idKonsumen});
}

class ClearShopEvent extends ShopEvent {}
