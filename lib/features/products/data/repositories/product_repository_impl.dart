import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:dummy_clean_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_list_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  final NetworkInfo networkInfo;
  final ProductRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, ProductListEntity>> getProductList() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getProductList());
      } on ServerException {
        return Left(ServerFailure());
      } on SocketException {
        return Left(ClientFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
