import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/data/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/client.mock.dart';
import '../mock/request.mock.dart';
import '../mock/response.mock.dart';





void main() {
  group('ProductService', () {
    // Initialize a mock client and the ProductService
    late MockChopperClientMixin mockClient;
    late ProductService productService;
    late MockResponse mockResponse;
    late MockRequest mockRequest;
    setUp(() {
      mockClient = MockChopperClient();
      productService = ProductService.create(mockClient);
      mockResponse = MockResponse();
      mockRequest = MockRequest();
      registerFallbackValue(mockRequest);
    });

    const tProduct = ProductJsonModel.test();

    final tProductId = tProduct.id ?? 1;
    final tProductMap = tProduct.toJson();

    test(
        '''fetchProductDetail makes correct HTTP request and returns the product detail''',
        () async {
      when(() => mockClient.baseUrl)
          .thenReturn(Uri.parse(AppConstants.kbaseUrl));

      when(() => mockResponse.isSuccessful).thenReturn(true);
      when(() => mockResponse.body).thenReturn(tProductMap);
      when(() => mockResponse.statusCode).thenReturn(HttpStatus.ok);
      when(
        () => mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(
          any(),
        ),
      ).thenAnswer((_) async => mockResponse);

      // Arrange
      final response = await productService.fetchProductDetail(tProductId);
      // Assert
      verify(
        () => mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(
          any(
            that: isA<Request>()
                .having((req) => req.method, 'method', HttpMethod.Get)
                .having(
                  (req) => req.url.path,
                  'path',
                  endsWith(
                    '$kProductServicePath/$tProductId',
                  ),
                ),
          ),
        ),
      ).called(1);
      expect(response.isSuccessful, true);
      expect(response.body, tProductMap);
      expect(response.statusCode, 200);

      // Act
    });

    test('''
        requests should be unsuccessfull when status
         is not between 200-300
         ''', () async {
      when(() => mockClient.baseUrl)
          .thenReturn(Uri.parse(AppConstants.kbaseUrl));
      when(() => mockResponse.isSuccessful).thenReturn(false);
      when(() => mockResponse.statusCode).thenReturn(HttpStatus.badRequest);
      // Arrange
      when(
        () =>
            mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(any()),
      ).thenAnswer(
        (_) async => mockResponse,
      );

      final response = await productService.fetchProducts();
      // Act & Assert
      expect(response.isSuccessful, equals(false));
      expect(
        response.statusCode,
        greaterThanOrEqualTo(HttpStatus.badRequest),
      );
    });

    final tProductListMap = <String, dynamic>{
      'products': [tProductMap],
    };

    test(
        '''fetchProductList makes correct HTTP request and returns the product list''',
        () async {
      // Arrange
      when(() => mockResponse.isSuccessful).thenReturn(true);
      when(() => mockResponse.body).thenReturn(tProductListMap);
      when(() => mockResponse.statusCode).thenReturn(HttpStatus.ok);
      when(
        () => mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(
          any(),
        ),
      ).thenAnswer((_) async => mockResponse);

      when(() => mockClient.baseUrl)
          .thenReturn(Uri.parse(AppConstants.kbaseUrl));

      // Act
      final response = await productService.fetchProducts();

      // Assert
      verify(
        () => mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(
          any(
            that: isA<Request>()
                .having((req) => req.method, 'method', 'GET')
                .having(
                  (req) => req.url.path,
                  'path',
                  endsWith(
                    kProductServicePath,
                  ),
                ),
          ),
        ),
      ).called(1);

      expect(response.isSuccessful, true);
      expect(response.body, tProductListMap);
      expect(response.statusCode, 200);
    });

    test('''
        requests should be unsuccessfull when status
         is not between 200-300
         ''', () async {
      when(() => mockClient.baseUrl)
          .thenReturn(Uri.parse(AppConstants.kbaseUrl));
      when(() => mockResponse.isSuccessful).thenReturn(false);
      when(() => mockResponse.statusCode).thenReturn(HttpStatus.badRequest);
      // Arrange
      when(
        () =>
            mockClient.send<Map<String, dynamic>, Map<String, dynamic>>(any()),
      ).thenAnswer(
        (_) async => mockResponse,
      );

      final response = await productService.fetchProducts();
      // Act & Assert
      expect(response.isSuccessful, equals(false));
      expect(
        response.statusCode,
        greaterThanOrEqualTo(HttpStatus.badRequest),
      );
    });
  });
}
