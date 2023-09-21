import 'package:dummy_clean_project/core/utils/typedef.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  ApiCallResult<List<ProductEntity>> getProductList();
  ApiCallResult<ProductEntity> getProductDetail(int productId);
}
