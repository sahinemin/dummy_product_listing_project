import 'package:bloc/bloc.dart';
import 'package:dummy_clean_project/core/error/failure_map.dart';
import 'package:dummy_clean_project/core/usecases/usecase.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_list_entity.dart';
import 'package:dummy_clean_project/features/products/domain/usecases/get_product_list.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.getProductList) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchProductList) {
        emit(ProductLoading());
        final failureOrProductList = await getProductList(
          NoParameters(),
        );
        failureOrProductList.fold(
          (failure) => emit(
            ProductListFailed(FailureMap().mapFailureToMessage(failure)),
          ),
          (productList) => emit(
            ProductListLoaded(productList: productList),
          ),
        );
      }
    });
  }
  final GetProductList getProductList;
}
