import 'package:dummy_clean_project/features/products/presentation/views/product_detail_page.dart';
import 'package:dummy_clean_project/features/products/presentation/views/product_list_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final routes = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/productDetail',
        builder: (context, state) => const ProductDetailPage(),
      ),
    ],
  );
}
