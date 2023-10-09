import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/data/service/product_service.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductJsonModel>> getProductList();
  Future<ProductJsonModel> getProductDetail(int productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required NetworkInfo networkInfo,
    required ProductService productListService,
  })  : _networkInfo = networkInfo,
        _productService = productListService;

  final NetworkInfo _networkInfo;
  final ProductService _productService;
  @override
  Future<List<ProductJsonModel>> getProductList() async {
    if (!await _networkInfo.isConnected) {
      throw const NetworkException();
    }
    final response = await _productService.fetchProducts();
    if (response.isSuccessful) {
      final productList = response.body!['products'] as List<dynamic>;
      return productList
          .map((e) => ProductJsonModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error.toString(), response.statusCode);
    }
  }

  @override
  Future<ProductJsonModel> getProductDetail(int productId) async {
    if (!await _networkInfo.isConnected) {
      throw const NetworkException();
    }
    final response = await _productService.fetchProductDetail(productId);
    if (response.isSuccessful) {
      final product = response.body!;
      return ProductJsonModel.fromJson(product);
    } else {
      throw ServerException(response.error.toString(), response.statusCode);
    }
  }
}
