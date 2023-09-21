part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductListLoaded extends ProductState {
  const ProductListLoaded({
    required this.productList,
  });
  final List<ProductEntity> productList;
  @override
  List<Object> get props => [productList];
}

final class ProducDetailLoaded extends ProductState {
  const ProducDetailLoaded({
    required this.product,
  });
  final ProductEntity product;
  @override
  List<Object> get props => [product];
}

final class ProductListFailed extends ProductState {
  const ProductListFailed(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
