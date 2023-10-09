// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:dummy_clean_project/features/products/presentation/views/product_detail_page.dart'
    as _i1;
import 'package:dummy_clean_project/features/products/presentation/views/product_list_page.dart'
    as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ProductDetailRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductDetailPage(),
      );
    },
    ProductListRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ProductListPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ProductDetailPage]
class ProductDetailRoute extends _i3.PageRouteInfo<void> {
  const ProductDetailRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ProductDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProductListPage]
class ProductListRoute extends _i3.PageRouteInfo<void> {
  const ProductListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ProductListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
