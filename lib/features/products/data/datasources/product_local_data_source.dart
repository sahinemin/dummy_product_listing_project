import 'dart:convert';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ProductLocalDataSource {
  Future<void> cacheProductList(List<ProductJsonModel> productList);
  List<ProductJsonModel>? getCachedProductList();
  bool get hasCachedProductList;
}

const cachedProductList = 'CACHED_PRODUCT_LIST';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheProductList(List<ProductJsonModel> productList) {
    return sharedPreferences.setString(
      cachedProductList,
      jsonEncode(productList),
    );
  }

  @override
  List<ProductJsonModel>? getCachedProductList() {
    if (!hasCachedProductList) {
      return null;
    }

    final jsonString = sharedPreferences.getString(cachedProductList);
    final decodedString = jsonDecode(jsonString!) as List<dynamic>;
    return decodedString
        .map((e) => ProductJsonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  bool get hasCachedProductList =>
      sharedPreferences.containsKey(cachedProductList);
}
