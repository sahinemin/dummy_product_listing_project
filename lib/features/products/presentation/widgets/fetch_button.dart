import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchButton extends StatefulWidget {
  const FetchButton({
    super.key,
  });

  @override
  State<FetchButton> createState() => _FetchButtonState();
}

class _FetchButtonState extends State<FetchButton> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isClicked
          ? null
          : () {
              setState(() {
                _isClicked = !_isClicked;
              });
              Future.delayed(
                const Duration(seconds: 1),
                () => BlocProvider.of<ProductBloc>(context).add(
                  FetchProductList(),
                ),
              );
            },
      child: const Text('fetch'),
    );
  }
}
