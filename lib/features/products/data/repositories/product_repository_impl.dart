import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/utils/typedef.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_local_data_source.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

final class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductLocalDataSource localDataSource,
    required ProductRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  ApiCallResult<List<ProductEntity>> getProductList() async {
    if (_localDataSource.hasCachedProductList) {
      return Right(_localDataSource.getCachedProductList()!);
    }
    final result =
        await ApiRequest.makeRequest(_remoteDataSource.getProductList);
    if (result.isRight()) {
      await _localDataSource.cacheProductList(
        result.getOrElse(() => <ProductJsonModel>[]),
      );
    }
    return result;
  }

  @override
  ApiCallResult<ProductEntity> getProductDetail(int productId) async {
    return ApiRequest.makeRequest(
      () => _remoteDataSource.getProductDetail(productId),
    );
  }
}
