import 'package:auto_route/auto_route.dart';
import 'package:dummy_clean_project/config/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  factory AppRouter() {
    return _singleton;
  }

  AppRouter._();
  static final AppRouter _singleton = AppRouter._();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ProductListRoute.page, initial: true),
        AutoRoute(page: ProductDetailRoute.page),
      ];
}
