import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/get_product_detail.mock.dart';
import '../mock/get_product_list.mock.dart';

void main() {
  late GetProductList getProductList;
  late GetProductDetail getProductDetail;
  late ProductBloc bloc;
  const tgetProductListParams = NoParameters();
  const tgetProductDetailParams = ProductDetailParams.empty();

  //const tServerFailure = ServerFailure('message', statusCode: 400);

  setUp(() {
    getProductList = MockGetProductList();
    getProductDetail = MockGetProductDetail();
    bloc = ProductBloc(
      getProductList,
      getProductDetail,
    );
    registerFallbackValue(tgetProductListParams);
    registerFallbackValue(tgetProductDetailParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [Product Initial', () async {
    expect(bloc.state, const ProductInitial());
  });

  group('getProductDetail', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductDetailLoaded] when successful',
      build: () {
        when(() => getProductDetail(any())).thenAnswer(
          (_) async => const Right(ProductEntity.test()),
        );
        return bloc;
      },
      act: (cubit) =>
          cubit.add(FetchProductDetail(tgetProductDetailParams.productId)),
      expect: () => const [
        ProductLoading(),
        ProductDetailLoaded(product: ProductEntity.test()),
      ],
      verify: (_) {
        verify(() => getProductDetail(tgetProductDetailParams)).called(1);
        verifyNoMoreInteractions(getProductDetail);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductFailed] when unsuccessful',
      build: () {
        when(() => getProductDetail(any())).thenAnswer(
          (_) async => const Left(ClientFailure('message')),
        );
        return bloc;
      },
      act: (cubit) =>
          cubit.add(FetchProductDetail(tgetProductDetailParams.productId)),
      expect: () => const [
        ProductLoading(),
        ProductFailed('message'),
      ],
      verify: (_) {
        verify(() => getProductDetail(tgetProductDetailParams)).called(1);
        verifyNoMoreInteractions(getProductDetail);
      },
    );
  });

  group('getProductList', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductListLoaded] when successful',
      build: () {
        when(() => getProductList(any())).thenAnswer(
          (_) async => const Right([ProductEntity.test()]),
        );
        return bloc;
      },
      act: (cubit) => cubit.add(const FetchProductList()),
      expect: () => [
        const ProductLoading(),
        const ProductListLoaded(productList: [ProductEntity.test()]),
      ],
      verify: (_) {
        verify(() => getProductList(tgetProductListParams)).called(1);
        verifyNoMoreInteractions(getProductList);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [ProductLoading, ProductListLoaded] when unsuccessful',
      build: () {
        when(() => getProductList(any())).thenAnswer(
          (_) async => const Left(ClientFailure('message')),
        );
        return bloc;
      },
      act: (cubit) => cubit.add(const FetchProductList()),
      expect: () => const [
        ProductLoading(),
        ProductFailed('message'),
      ],
      verify: (_) {
        verify(() => getProductList(tgetProductListParams)).called(1);
        verifyNoMoreInteractions(getProductDetail);
      },
    );
  });
}
