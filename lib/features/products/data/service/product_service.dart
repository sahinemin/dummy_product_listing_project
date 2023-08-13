import 'dart:async';
import 'package:chopper/chopper.dart';
part 'product_service.chopper.dart';

@ChopperApi(baseUrl: '/products')
abstract class ProductListService extends ChopperService {
  static ProductListService create([ChopperClient? client]) =>
      _$ProductListService(client);
  @Get()
  Future<Response<Map<String, dynamic>>> fetchProducts();
}
