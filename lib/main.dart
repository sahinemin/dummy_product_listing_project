import 'package:dummy_clean_project/config/router/router.dart';
import 'package:dummy_clean_project/config/theme/theme.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/injection_container.dart' as di;
import 'package:dummy_clean_project/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const DummyApp());
}

final class DummyApp extends StatelessWidget {
  const DummyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme().getLightTheme,
        darkTheme: AppTheme().getDarkTheme,
        routerConfig: AppRouter.routes,
      ),
    );
  }
}
