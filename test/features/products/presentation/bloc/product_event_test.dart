import 'package:dummy_clean_project/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductEvent', () {
    test('FetchProductList props are empty', () {
      const event = FetchProductList();
      expect(event.props, <ProductEvent>[]);
    });

    test('FetchProductDetail props contains the product ID', () {
      const productId = 1;
      const event = FetchProductDetail(productId);
      expect(event.props, [productId]);
    });

    test('FetchProductDetail should be equatable based on product ID', () {
      const event1 = FetchProductDetail(1);
      const event2 = FetchProductDetail(1);
      const event3 = FetchProductDetail(2);

      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
    });
  });
}
