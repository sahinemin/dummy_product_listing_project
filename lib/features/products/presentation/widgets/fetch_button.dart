import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class FetchButton extends StatefulWidget {
  const FetchButton({
    super.key,
  });
  @override
  State<FetchButton> createState() => _FetchButtonState();
}

class _FetchButtonState extends State<FetchButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<ProductBloc>().add(
                  FetchProductList(),
                );
          },
          child: const Text('fetch'),
        );
      },
    );
  }
}
