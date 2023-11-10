part of 'product_bloc.dart';

abstract interface class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductListLoaded extends ProductState {
  const ProductListLoaded({
    required this.productList,
  });
  final List<ProductEntity> productList;
  @override
  List<Object> get props => [productList];
}

final class ProductDetailLoaded extends ProductState {
  const ProductDetailLoaded({
    required this.product,
  });
  final ProductEntity product;
  @override
  List<Object> get props => [product];
}

final class ProductFailed extends ProductState {
  const ProductFailed(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
