import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/data/repositories/product_repository_impl.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/product_remote_data_source.mock.dart';



void main() {
  late ProductRemoteDataSource remoteDataSource;
  late ProductRepositoryImpl repositoryImpl;
  late NetworkInfo networkInfo;
  setUp(() {
    remoteDataSource = MockProductRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = ProductRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
  });

  test('should check if the device is online', () {
    final expectedNetworkInfoAnswer = Future<bool>.value(false);
    // arrange
    when(() => networkInfo.isConnected)
        .thenAnswer((_) => expectedNetworkInfoAnswer);
    // assert
    expect(expectedNetworkInfoAnswer, equals(networkInfo.isConnected));
  });

  group('getProductList', () {
    final expectedNetworkInfoAnswer = Future<bool>.value(true);
    test(
      'should call the [RemoteDataSource.getProductList] '
      'and get product list successfully '
      'when the call to the remote source is successful',
      () async {
        //arrange

        final expectedProductList = Future.value(<ProductJsonModel>[]);

        when(() => remoteDataSource.getProductList()).thenAnswer(
          (_) async => expectedProductList,
        );

        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => expectedNetworkInfoAnswer);

        //act
        final result = await repositoryImpl.getProductList();

        //assert

        verify(() => remoteDataSource.getProductList()).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          isA<Right<Failure, List<ProductEntity>>>(),
        );
      },
    );

    test(
      'should return a Network Failure when the call to remote '
      'has thrown a Network Exception',
      () async {
        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => Future<bool>.value(false));

        when(() => remoteDataSource.getProductList())
            .thenThrow(const NetworkException());

        final result = await repositoryImpl.getProductList();

        //assert

        verify(() => remoteDataSource.getProductList()).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          const Left<NetworkFailure, List<ProductEntity>>(
            NetworkFailure('No Internet Connection', statusCode: 0),
          ),
        );
      },
    );
    test(
      'should return a Server Failure when the call to remote '
      'has thrown a ServerException',
      () async {
        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => Future<bool>.value(false));

        when(() => remoteDataSource.getProductList())
            .thenThrow(const SocketException('Socket has been closed'));

        final result = await repositoryImpl.getProductList();

        //assert

        verify(() => remoteDataSource.getProductList()).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          const Left<ClientFailure, List<ProductEntity>>(
            ClientFailure('Socket has been closed'),
          ),
        );
      },
    );
    test(
      'should return a Client Failure when the call to remote '
      'has thrown a Socket Exception',
      () async {
        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => expectedNetworkInfoAnswer);

        when(() => remoteDataSource.getProductList())
            .thenThrow(const ServerException('Unknown Error Occured', 500));

        final result = await repositoryImpl.getProductList();

        //assert

        verify(() => remoteDataSource.getProductList()).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          const Left<ServerFailure, List<ProductEntity>>(
            ServerFailure('Unknown Error Occured', statusCode: 500),
          ),
        );
      },
    );
  });

  group('getProductDetail', () {
    final expectedNetworkInfoAnswer = Future<bool>.value(true);
    const productId = 1;
    test(
      'should call the [RemoteDataSource.getProductDetail] '
      'and get product list successfully '
      'when the call to the remote source is successful',
      () async {
        //arrange
        when(() => remoteDataSource.getProductDetail(productId))
            .thenAnswer((_) async => const ProductJsonModel.test());
        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => expectedNetworkInfoAnswer);
        final result = await repositoryImpl.getProductDetail(productId);
        verify(() => remoteDataSource.getProductDetail(productId)).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          isA<Right<Failure, ProductEntity>>(),
        );
      },
    );
    test(
      'should return a Failure when the call to remote '
      'is unsuccessful',
      () async {
        when(() => networkInfo.isConnected)
            .thenAnswer((_) async => expectedNetworkInfoAnswer);

        when(() => remoteDataSource.getProductDetail(productId))
            .thenThrow(const ServerException('Unknown Error Occured', 500));

        final result = await repositoryImpl.getProductDetail(productId);

        //assert

        verify(() => remoteDataSource.getProductDetail(productId)).called(1);
        verifyNoMoreInteractions(remoteDataSource);

        expect(
          result,
          const Left<ServerFailure, ProductEntity>(
            ServerFailure('Unknown Error Occured', statusCode: 500),
          ),
        );
      },
    );
  });
}
