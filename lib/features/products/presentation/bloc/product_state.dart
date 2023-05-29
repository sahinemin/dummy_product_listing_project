part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductListLoaded extends ProductState {
  const ProductListLoaded({
    required this.productList,
  });
  final ProductListEntity productList;
}

class ProductListFailed extends ProductState {
  const ProductListFailed(this.message);
  final String message;
}
