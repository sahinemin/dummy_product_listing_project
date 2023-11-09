import 'package:dummy_clean_project/config/router/app_router.dart';
import 'package:dummy_clean_project/config/theme/theme.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class DummyApp extends StatelessWidget {
  const DummyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme().getDarkTheme,
        darkTheme: AppTheme().getDarkTheme,
        routerConfig: router.config(),
      ),
    );
  }
}
