import 'package:auto_route/auto_route.dart';
import 'package:dummy_clean_project/config/router/app_router.gr.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        state as ProductListLoaded;
        return ListView.builder(
          itemCount: state.productList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: TextButton(
                onPressed: () => pushToProductDetailPage(context, state, index),
                child: Text(state.productList.elementAt(index).brand ?? ''),
              ),
            );
          },
        );
      },
    );
  }

  void pushToProductDetailPage(
    BuildContext context,
    ProductListLoaded state,
    int index,
  ) {
    context.read<ProductBloc>().add(
          FetchProductDetail(
            state.productList.elementAt(index).id ?? 1,
          ),
        );
    context.router.push(const ProductDetailRoute());
  }
}
