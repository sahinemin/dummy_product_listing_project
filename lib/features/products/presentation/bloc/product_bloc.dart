import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._getProductList, this._getProductDetail)
      : super(ProductInitial()) {
    var localProductList = <ProductEntity>[];
    on<ProductEvent>((event, emit) async {
      if (event is FetchProductList) {
        emit(ProductLoading());
        if (localProductList.isNotEmpty) {
          emit(ProductListLoaded(productList: localProductList));
          return;
        }
        final failureOrProductList = await _getProductList(
          NoParameters(),
        );

        failureOrProductList.fold(
          (failure) => emit(
            ProductListFailed(
              failure.message,
            ),
          ),
          (productList) => {
            emit(
              ProductListLoaded(productList: productList),
            ),
            localProductList = productList,
          },
        );
      } else if (event is FetchProductDetail) {
        emit(ProductLoading());
        final failureOrProductList = await _getProductDetail(
          ProductDetailParams(productId: event.productId),
        );

        failureOrProductList.fold(
          (failure) => emit(
            ProductListFailed(
              failure.message,
            ),
          ),
          (product) => emit(
            ProducDetailLoaded(product: product),
          ),
        );
      } else if (event is ReturnToProductListLoaded) {
        emit(ProductListLoaded(productList: localProductList));
      }
    });
  }
  final GetProductList _getProductList;
  final GetProductDetail _getProductDetail;
}
