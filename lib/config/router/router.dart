import 'package:dummy_clean_project/features/products/presentation/pages/products_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsPage(),
      ),
    ],
  );
}
