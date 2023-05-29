import 'package:dartz/dartz.dart';

import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_list_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

class GetProductList extends UseCase<ProductListEntity, NoParameters> {

  GetProductList(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, ProductListEntity>> execute() {
    return repository.getProductList();
  }

  @override
  Future<Either<Failure, ProductListEntity>> call(NoParameters params) {
    return repository.getProductList();
  }
}
