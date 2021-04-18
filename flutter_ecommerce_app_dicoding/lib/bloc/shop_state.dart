part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopCheckLoading extends ShopState {}

class ShopCreateLoading extends ShopState {}

class ShopError extends ShopState {
  final String error;
  ShopError({this.error});
}

class ShopCheckSuccess extends ShopState {
  final MyShopModel myShopModel;
  ShopCheckSuccess({this.myShopModel});
}

class ShopCreateSuccess extends ShopState {
  final MyShopModel myShopModel;
  ShopCreateSuccess({this.myShopModel});
}
