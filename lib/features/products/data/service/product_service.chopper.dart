// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, 
//prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ProductListService extends ProductListService {
  _$ProductListService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductListService;

  @override
  Future<Response<String>> fetchProducts() {
    final $url = Uri.parse('/products');
    final $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }
}
