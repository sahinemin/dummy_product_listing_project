part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductList extends ProductEvent {}

final class ReturnToProductListLoaded extends ProductEvent {}

final class FetchProductDetail extends ProductEvent {
  const FetchProductDetail(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}
