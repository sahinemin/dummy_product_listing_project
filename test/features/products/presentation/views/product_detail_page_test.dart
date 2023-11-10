import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:dummy_clean_project/features/products/presentation/views/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

class MockCustomRouter extends Mock implements StackRouter {}

class FakeProductEvent extends Fake implements ProductEvent {}

class FakeProductState extends Fake implements ProductState {}

void main() {
  group('ProductDetailPage', () {
    late ProductBloc productBloc;
    late StackRouter router;

    setUpAll(() {
      registerFallbackValue(FakeProductEvent());
      registerFallbackValue(FakeProductState());
    });

    setUp(() {
      productBloc = MockProductBloc();
      router = MockCustomRouter();
      when(() => productBloc.state).thenReturn(const ProductLoading());
    });

    testWidgets(
        'should display CircularProgressIndicator when state is ProductLoading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => productBloc,
            child: const ProductDetailPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'should display product description when state is ProductDetailLoaded',
        (WidgetTester tester) async {
      const product = ProductEntity(description: 'Test Description');
      when(() => productBloc.state)
          .thenReturn(const ProductDetailLoaded(product: product));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => productBloc,
            child: const ProductDetailPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('should call onBack when the back button is pressed',
        (WidgetTester tester) async {
      when(() => productBloc.state).thenReturn(
          const ProductDetailLoaded(product: ProductEntity(description: '')),);
      when(() => router.pop()).thenAnswer((_) async => Future.value(true));
      await tester.pumpWidget(
        StackRouterScope(
          controller: router,
          stateHash: 0,
          child: MaterialApp(
            home: BlocProvider<ProductBloc>(
              create: (context) => productBloc,
              child: const ProductDetailPage(),
            ),
          ),
        ),
      );

      // Assume CustomAppBar uses an IconButton for the back button
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Verify that the router's pop method was called
      verify(() => router.pop()).called(1);

      // Verify that the ProductBloc's add method was called
      // with FetchProductList
      verify(() => productBloc.add(const FetchProductList())).called(1);
    });

    // Additional tests can be written to cover other functionalities
  });
}
