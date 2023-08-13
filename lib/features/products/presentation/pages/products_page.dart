import 'package:dummy_clean_project/core/widgets/custom_app_bar.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/features/products/presentation/widgets/fetch_button.dart';
import 'package:dummy_clean_project/features/products/presentation/widgets/product_list.dart';
import 'package:dummy_clean_project/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(overrideTitle: 'Products'),
      body: BlocProvider(
        create: (context) => sl<ProductBloc>(),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductListFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is ProductListLoaded) {
              return ProductList(state: state);
            } else if (state is ProductLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProductInitial) {
              return const FetchButton();
            } else {
              return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}
