import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    required this.state,
    super.key,
  });

  final ProductListLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.productList.products?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            state.productList.products?.elementAt(index).brand ?? '',
          ),
        );
      },
    );
  }
}
