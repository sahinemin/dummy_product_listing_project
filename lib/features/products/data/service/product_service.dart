import 'dart:async';
import 'package:chopper/chopper.dart';
part 'product_service.chopper.dart';

@ChopperApi(baseUrl: '/products')
abstract interface class ProductService extends ChopperService {
  static ProductService create([ChopperClient? client]) =>
      _$ProductService(client);
  @Get()
  Future<Response<Map<String, dynamic>>> fetchProducts();
  @Get(path: '/{id}')
  Future<Response<Map<String, dynamic>>> fetchProductDetail(
    @Path('id') int productId,
  );
}
