part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ViewProductPopularEvent extends ProductEvent {}

class ViewProductDiscountEvent extends ProductEvent {}

class ClearEventProduct extends ProductEvent {}

class InitialEventPopular extends ProductEvent {}

class InitialEventDiscount extends ProductEvent {}

class InitialEventDetailProduct extends ProductEvent {}

class ViewProductDetailEvent extends ProductEvent {
  final String productId;
  ViewProductDetailEvent({this.productId});
}
