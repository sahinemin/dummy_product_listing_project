import 'dart:convert';

import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/features/products/data/models/product_list_json_model.dart';
import 'package:dummy_clean_project/features/products/data/service/product_service.dart';

abstract class ProductRemoteDataSource {
  Future<ProductListJsonModel> getProductList();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required this.productListService,
  });
  final ProductListService productListService;
  @override
  Future<ProductListJsonModel> getProductList() async {
    final response = await productListService.fetchProducts();
    if (response.isSuccessful && response.body != null) {
      return ProductListJsonModel.fromJson(
        json.decode(response.body!) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
