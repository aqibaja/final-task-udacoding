part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductPupularInitial extends ProductState {}

class ProductPupularLoading extends ProductState {}

class ProductPupularError extends ProductState {
  final String error;
  ProductPupularError({this.error});
}

//data api login selesai di get
class ProductPupularLoaded extends ProductState {
  final List<PopularModel> popularModel;
  ProductPupularLoaded({this.popularModel});
}

class ProductDiscountInitial extends ProductState {}

class ProductDiscountLoading extends ProductState {}

class ProductDiscountError extends ProductState {
  final String error;
  ProductDiscountError({this.error});
}

//data api login selesai di get
class ProductDiscountLoaded extends ProductState {
  final List<DiscountModel> discountModel;
  ProductDiscountLoaded({this.discountModel});
}

//product Detail
class ProductDetailInitial extends ProductState {}

class ProductDetailLoading extends ProductState {}

class ProductDetailError extends ProductState {
  final String error;
  ProductDetailError({this.error});
}

//data api login selesai di get
class ProductDetailLoaded extends ProductState {
  final List<ProductModels> productModel;
  ProductDetailLoaded({this.productModel});
}
