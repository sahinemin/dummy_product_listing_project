import 'package:dummy_clean_project/config/router/router.dart';
import 'package:dummy_clean_project/config/theme/theme.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const DummyApp());
}

class DummyApp extends StatelessWidget {
  const DummyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme().getLightTheme,
      darkTheme: AppTheme().getDarkTheme,
      routerConfig: AppRouter.routes,
    );
  }
}
