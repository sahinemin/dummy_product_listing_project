import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_list_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListEntity>> getProductList();
}
