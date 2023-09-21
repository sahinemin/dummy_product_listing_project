import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:dummy_clean_project/features/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tProductJsonModel = ProductJsonModel.test();
  test('should be a subclass of ProductEntity', () async {
    expect(tProductJsonModel, isA<ProductEntity>());
  });
  final tDecodedJson = fixture('product.json');
  group('fromJson', () {
    test('should return a [ProductJsonModel] with the right data', () {
      // arrange
      final result =
          ProductJsonModel.fromJson(tDecodedJson as Map<String, dynamic>);

      // act
      expect(result, tProductJsonModel);
      // assert
    });
  });

  group('copyWith', () {
    test('should return a [ProductJsonModel] with different properties ', () {
      // arrange
      const expectedTitle = 'sample title';
      const expectedId = 0;
      const expectedDescription = 'desc';
      const expectedPrice = 0;

      // act
      final result = tProductJsonModel.copyWith(
        title: expectedTitle,
        id: expectedId,
        description: expectedDescription,
        price: expectedPrice,
      );

      // assert
      expect(result.title, expectedTitle);
      expect(result.id, expectedId);
      expect(result.description, expectedDescription);
      expect(result.price, expectedPrice);
    });
  });
  group('toJson', () {
    test('should return produc.json', () {
      // arrange
      final result = tProductJsonModel.toJson();
      // act
      expect(result, tDecodedJson);
      // assert
    });
  });
}
