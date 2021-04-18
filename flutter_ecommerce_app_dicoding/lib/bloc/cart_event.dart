part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ListCartEvent extends CartEvent {
  final String konsumenId;
  ListCartEvent({this.konsumenId});
}

class AddCartEvent extends CartEvent {
  final String konsumenId;
  final String productId;
  AddCartEvent({this.konsumenId, this.productId});
}

class AddTotalCartEvent extends CartEvent {
  final String konsumenId;
  final String productId;
  AddTotalCartEvent({this.konsumenId, this.productId});
}

class DeleteCartEvent extends CartEvent {
  final String konsumenId;
  final String productId;
  DeleteCartEvent({this.konsumenId, this.productId});
}

class ClearEventCart extends CartEvent {}
