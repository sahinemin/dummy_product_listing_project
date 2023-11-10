import 'package:dummy_clean_project/core/utils/typedef.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

final class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ProductRemoteDataSource _remoteDataSource;
  @override
  ApiCallResult<List<ProductEntity>> getProductList() async {
    return ApiRequest.makeRequest(_remoteDataSource.getProductList);
  }

  @override
  ApiCallResult<ProductEntity> getProductDetail(int productId) async {
    return ApiRequest.makeRequest(
      () => _remoteDataSource.getProductDetail(productId),
    );
  }
}
