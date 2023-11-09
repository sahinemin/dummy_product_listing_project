import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_detail.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

final class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
     GetProductList getProductList,
     GetProductDetail getProductDetail,
  )  : _getProductDetail = getProductDetail,
        _getProductList = getProductList,
        super(const ProductInitial()) {
    
    Future<void> fetchProductListHandler(
      FetchProductList event,
      Emitter<ProductState> emit,
    ) async {
      emit(const ProductLoading());
      

      final failureOrProductList = await _getProductList(
        const NoParameters(),
      );

      failureOrProductList.fold(
        (failure) => emit(
          ProductFailed(
            failure.message,
          ),
        ),
        (productList) => emit(
            ProductListLoaded(productList: productList),
          ),);
    }

    Future<void> fetchProductDetailHandler(
      FetchProductDetail event,
      Emitter<ProductState> emit,
    ) async {
      emit(const ProductLoading());
      final failureOrProductList = await _getProductDetail(
        ProductDetailParams(productId: event.productId),
      );

      failureOrProductList.fold(
        (failure) => emit(
          ProductFailed(
            failure.message,
          ),
        ),
        (product) => emit(
          ProducDetailLoaded(product: product),
        ),
      );
    }

    on<FetchProductList>(fetchProductListHandler);
    on<FetchProductDetail>(fetchProductDetailHandler);
  }
  final GetProductList _getProductList;
  final GetProductDetail _getProductDetail;
}
