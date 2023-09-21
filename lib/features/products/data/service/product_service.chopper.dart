// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

final class _$ProductListService extends ProductListService {
  _$ProductListService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductListService;

  @override
  Future<Response<Map<String, dynamic>>> fetchProducts() {
    final $url = Uri.parse('/products');
    final $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> fetchProductDetail(int productId) {
    final $url = Uri.parse('/products/$productId');
    final $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
