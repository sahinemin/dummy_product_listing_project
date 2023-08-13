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
    if (response.isSuccessful) {
      return ProductListJsonModel.fromJson(
        response.body!,
      );
    } else {
      throw ServerException();
    }
  }
}
