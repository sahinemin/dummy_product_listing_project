import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/repositories/product_repository.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/product_repository.mock.dart';



void main() {
  late GetProductList usecase;
  late ProductRepository repository;
  setUp(() {
    repository = MockProductRepository();
    usecase = GetProductList(repository);
  });
  test('should call [ProductRepository.getProductList()]', () async {
    when(() => repository.getProductList())
        .thenAnswer((invocation) async => const Right([]));
    final result = await usecase(NoParameters());
    expect(result, const Right<dynamic, List<ProductEntity>>([]));
    verify(() => repository.getProductList()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
