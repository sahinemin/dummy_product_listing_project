import 'dart:convert';

import 'package:chopper/chopper.dart';
//import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/data/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

//import '../mock/network_info.mock.dart';

class MockProductService extends Mock implements ProductService {}

void main() {
  late ProductService tProductService;
  //late ProductRemoteDataSource tProductRemoteDataSource;
  //late NetworkInfo tNetworkInfo;
  setUp(() {
    tProductService = MockProductService();
    //tNetworkInfo = MockNetworkInfo();
   /* tProductRemoteDataSource = ProductRemoteDataSourceImpl(
      networkInfo: tNetworkInfo,
      productListService: tProductService,
    );*/
  });
  const productId = 1;
  final tProductMap = const ProductJsonModel.test().toJson();
  final tProductJson = jsonEncode(tProductMap);

  final response = Response<Map<String, dynamic>>(
    http.Response(tProductJson, 200),
    tProductMap,
  );

  group('get product detail', () {
    test('description', () async {
      when(
        () => tProductService.fetchProductDetail(productId),
      ).thenAnswer((_) async => response);

      final methodCall = tProductService.fetchProductDetail;

      expect(methodCall(productId), completes);
      verify(() => tProductService.fetchProductDetail(productId)).called(1);
      verifyNoMoreInteractions(tProductService);
    });
  });
}
