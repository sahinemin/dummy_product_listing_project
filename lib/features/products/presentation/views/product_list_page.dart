import 'package:dummy_clean_project/core/widgets/custom_app_bar.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';

import 'package:dummy_clean_project/features/products/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(overrideTitle: 'Products'),
      body: BlocConsumer<ProductBloc, ProductState>(
        bloc: context.read<ProductBloc>()..add(FetchProductList()),
        listener: (context, state) {
          if (state is ProductListFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            ProductListLoaded() => const ProductList(),
            ProductLoading() => const CircularProgressIndicator(),
            _ => const Placeholder(),
          };
        },
      ),
    );
  }
}