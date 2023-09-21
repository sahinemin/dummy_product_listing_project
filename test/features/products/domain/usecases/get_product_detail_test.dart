import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/product_repository.mock.dart';

void main() {
  late GetProductDetail usecase;
  late ProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    usecase = GetProductDetail(repository);
  });

  const productEntity = ProductEntity.test();
  const productDetailParams = ProductDetailParams.empty();

  test('should call [ProductRepository.getProductDetail()]', () async {
    when(() => repository.getProductDetail(any()))
        .thenAnswer((invocation) async => const Right(productEntity));

    final result = await usecase(productDetailParams);

    expect(result, const Right<dynamic, ProductEntity>(productEntity));

    verify(() => repository.getProductDetail(productDetailParams.productId))
        .called(1);

    verifyNoMoreInteractions(repository);
  });
}
