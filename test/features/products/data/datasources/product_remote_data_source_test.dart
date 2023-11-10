import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/platform/network_info.mock.dart';
import '../../service/mock/product_service.mock.dart';
import '../../service/mock/response.mock.dart';

void main() {
  late ProductRemoteDataSource tProductRemoteDataSource;
  late ProductService tProductService;
  late NetworkInfo tNetworkInfo;
  late MockResponse tMockResponse;

  setUp(() {
    tMockResponse = MockResponse();
    tProductService = MockProductService();
    tNetworkInfo = MockNetworkInfo();
    tProductRemoteDataSource = ProductRemoteDataSourceImpl(
      networkInfo: tNetworkInfo,
      productListService: tProductService,
    );
  });
  const tProduct = ProductJsonModel.test();

  final tProductId = tProduct.id ?? 1;
  final tProductMap = tProduct.toJson();

  group('get product detail', () {
    test('''
         should return product detail ,
         when the call to remote data source is successful
         ''', () async {
      when(() => tMockResponse.isSuccessful).thenReturn(true);
      when(() => tMockResponse.statusCode).thenReturn(200);
      when(() => tMockResponse.body).thenReturn(tProductMap);
      // arrange
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tProductService.fetchProductDetail(tProductId))
          .thenAnswer((_) async => tMockResponse);
      // act
      final result =
          await tProductRemoteDataSource.getProductDetail(tProductId);
      // assert
      expect(result, equals(tProduct));
    });

    test('''
         should throw NetworkException,
         when device is not connected to the internet,
         ''', () {
      // arrange
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final call = tProductRemoteDataSource.getProductDetail(tProductId);
      // assert
      expect(() => call, throwsA(isA<NetworkException>()));
    });
    test('''
         should throw ServerException,
         when the Server is down,
         ''', () async {
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tMockResponse.isSuccessful).thenReturn(false);
      when(() => tMockResponse.statusCode).thenReturn(500);
      when(() => tProductService.fetchProductDetail(tProductId))
          .thenAnswer((_) async => tMockResponse);
      when(() => tProductService.fetchProductDetail(tProductId))
          .thenAnswer((invocation) async => tMockResponse);

      // act
      final call = tProductRemoteDataSource.getProductDetail(tProductId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('''
         should throw ClientException,
         when the request is bad,
         ''', () async {
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tProductService.fetchProductDetail(tProductId))
          .thenThrow(ClientException('message'));
      // act
      final call = tProductRemoteDataSource.getProductDetail(tProductId);
      // assert
      expect(() => call, throwsA(isA<ClientException>()));
    });
  });
  const tProductList = <ProductJsonModel>[tProduct];
  final tProductListMap = <String, dynamic>{
    'products': [tProductMap],
  };
  group('get product list', () {
    test('''
         should return product list ,
         when the call to remote data source is successful
         ''', () async {
      // arrange
      when(() => tMockResponse.isSuccessful).thenReturn(true);
      when(() => tMockResponse.statusCode).thenReturn(200);
      when(() => tMockResponse.body).thenReturn(tProductListMap);
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tProductService.fetchProducts())
          .thenAnswer((_) async => tMockResponse);
      // act
      final result = await tProductRemoteDataSource.getProductList();
      // assert
      expect(result, equals(tProductList));
    });

    test('''
         should throw ServerException,
         when the Server is down,
         ''', () async {
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tMockResponse.isSuccessful).thenReturn(false);
      when(() => tMockResponse.statusCode).thenReturn(500);
      when(() => tProductService.fetchProducts())
          .thenAnswer((invocation) async => tMockResponse);

      // act
      final call = tProductRemoteDataSource.getProductList();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('''
         should throw ClientException,
         when the request is bad,
         ''', () async {
      when(() => tNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => tProductService.fetchProducts())
          .thenThrow(ClientException('message'));
      // act
      final call = tProductRemoteDataSource.getProductList();
      // assert
      expect(() => call, throwsA(isA<ClientException>()));
    });
  });
}
