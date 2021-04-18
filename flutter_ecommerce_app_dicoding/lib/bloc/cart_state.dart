part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartListInitial extends CartState {}

class CartListLoading extends CartState {}

//data api login selesai di get
class CartListSuccess extends CartState {
  final List<ListCartModel> listCartModel;
  CartListSuccess({this.listCartModel});
}

class CartListFail extends CartState {}

class CartListError extends CartState {
  final String error;
  CartListError({this.error});
}

class CartAddInitial extends CartState {}

class CartAddLoading extends CartState {}

//data api login selesai di get
class CartAddSuccess extends CartState {
  final AddDeleteCartModel addCartModel;
  CartAddSuccess({this.addCartModel});
}

class CartAddError extends CartState {
  final String error;
  CartAddError({this.error});
}

class CartAddTotalInitial extends CartState {}

class CartAddTotalLoading extends CartState {}

//data api login selesai di get
class CartAddTotalSuccess extends CartState {
  final AddDeleteCartModel addCartModel;
  CartAddTotalSuccess({this.addCartModel});
}

class CartAddTotalError extends CartState {
  final String error;
  CartAddTotalError({this.error});
}

class CartDeleteInitial extends CartState {}

class CartDeleteLoading extends CartState {}

//data api login selesai di get
class CartDeleteSuccess extends CartState {
  final AddDeleteCartModel deleteCartModel;
  CartDeleteSuccess({this.deleteCartModel});
}

class CartDeleteError extends CartState {
  final String error;
  CartDeleteError({this.error});
}
