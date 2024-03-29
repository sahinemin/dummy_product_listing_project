import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/core/utils/typedef.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

class GetProductList extends UseCase<List<ProductEntity>, NoParameters> {
  GetProductList(this.repository);
  final ProductRepository repository;

  @override
  ApiCallResult<List<ProductEntity>> call(NoParameters params) {
    return repository.getProductList();
  }
}
