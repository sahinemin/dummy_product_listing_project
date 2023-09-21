import 'package:dummy_clean_project/core/widgets/custom_app_bar.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        overrideTitle: 'Products',
        onBack: () {
          BlocProvider.of<ProductBloc>(context)
              .add(ReturnToProductListLoaded());
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProducDetailLoaded) {
            return Text(state.product.description ?? '');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
