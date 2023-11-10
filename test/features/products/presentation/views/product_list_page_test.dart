import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/features/products/presentation/views/product_list_page.dart';
import 'package:dummy_clean_project/features/products/presentation/widgets/product_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

class FakeProductEvent extends Fake implements ProductEvent {}

class FakeProductState extends Fake implements ProductState {}

class MockRouter extends Mock implements StackRouter {}

void main() {
  group('ProductListPage', () {
    late ProductBloc productBloc;
    late List<ProductEntity> productList;
    late StackRouter mockRouter;

    setUpAll(() {
      productList = [const ProductEntity.test()];
      registerFallbackValue(FakeProductEvent());
      registerFallbackValue(FakeProductState());
      registerFallbackValue(const PageRouteInfo('/product-detail-page'));
    });

    setUp(() {
      productBloc = MockProductBloc();
      mockRouter = MockRouter();
    });

    testWidgets(
        'should display CircularProgressIndicator when state is ProductLoading',
        (WidgetTester tester) async {
      when(() => productBloc.state).thenReturn(const ProductLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => productBloc,
            child: const ProductListPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'should display ProductListViewBuilder when state is ProductListLoaded',
        (WidgetTester tester) async {
      when(() => productBloc.state).thenReturn(
        ProductListLoaded(productList: productList),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => productBloc,
            child: const ProductListPage(),
          ),
        ),
      );

      expect(find.byType(ProductListViewBuilder), findsOneWidget);
    });

    testWidgets('should display SnackBar when state is ProductFailed',
        (WidgetTester tester) async {
      const failureMessage = 'Failed to load products';
      whenListen(
        productBloc,
        Stream.fromIterable([const ProductFailed(failureMessage)]),
        initialState: const ProductLoading(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => productBloc,
            child: const ProductListPage(),
          ),
        ),
      );

      await tester.pump(); // Rebuild the widget with the new state.

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(failureMessage), findsOneWidget);
    });

    testWidgets('navigates to ProductDetailPage when a product is selected',
        (WidgetTester tester) async {
      // Mock the navigation call
      when(() => productBloc.state).thenReturn(
        const ProductListLoaded(productList: [ProductEntity(description: '')]),
      );
      when(() => mockRouter.push(any()))
          .thenAnswer((_) async => Future.value(true));

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        StackRouterScope(
          stateHash: 0,
          controller: mockRouter,
          child: MaterialApp(
            home: BlocProvider<ProductBloc>(
              create: (context) => productBloc,
              child: const ProductListPage(),
            ),
          ),
        ),
      );

      // Tap the button which should navigate to the ProductDetailPage
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle(); // wait for the navigation animation

      // Verify that the navigation to ProductDetailPage was pushed
      verify(() => mockRouter.push(any())).called(1);
    });
  });
}
