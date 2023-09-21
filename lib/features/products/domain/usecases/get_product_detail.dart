import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/core/utils/typedef.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

final class GetProductDetail
    extends UseCase<ProductEntity, ProductDetailParams> {
  GetProductDetail(this.repository);
  final ProductRepository repository;

  @override
  ApiCallResult<ProductEntity> call(ProductDetailParams params) {
    return repository.getProductDetail(params.productId);
  }
}
