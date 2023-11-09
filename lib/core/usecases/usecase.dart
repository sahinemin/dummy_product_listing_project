import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParameters {
  const NoParameters();
}

class ProductDetailParams extends Equatable {
  const ProductDetailParams({required this.productId});
  const ProductDetailParams.empty() : productId = 1;
  final int productId;
  @override
  List<Object?> get props => [productId];
}
