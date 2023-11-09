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
      final copiedProduct = tProductJsonModel.copyWith(
        id: 2,
        title: 'New Title',
        description: 'New Description',
        price: 200,
        discountPercentage: 20,
        rating: 5,
        stock: 10,
        brand: 'New Brand',
        category: 'New Category',
        thumbnail: 'new_thumbnail.jpg',
        images: ['new_image1.jpg', 'new_image2.jpg'],
      );

      // assert
      expect(copiedProduct.id, 2);
      expect(copiedProduct.title, 'New Title');
      expect(copiedProduct.description, 'New Description');
      expect(copiedProduct.price, 200);
      expect(copiedProduct.discountPercentage, 20.0);
      expect(copiedProduct.rating, 5.0);
      expect(copiedProduct.stock, 10);
      expect(copiedProduct.brand, 'New Brand');
      expect(copiedProduct.category, 'New Category');
      expect(copiedProduct.thumbnail, 'new_thumbnail.jpg');
      expect(copiedProduct.images, ['new_image1.jpg', 'new_image2.jpg']);
    });
  });
  test('should copy product with modified id', () {
    final copiedProduct = tProductJsonModel.copyWith(id: 2);
    expect(copiedProduct.id, 2);
    expect(copiedProduct.title, tProductJsonModel.title);
    // ... assert the rest of the properties are unchanged
  });
  test('should copy product with modified title', () {
    final copiedProduct = tProductJsonModel.copyWith(title: 'New Title');
    expect(copiedProduct.title, 'New Title');
    expect(copiedProduct.description, tProductJsonModel.description);
    // ... assert the rest of the properties are unchanged
  });
  test('should copy correctly with new description', () {
    final copiedProduct =
        tProductJsonModel.copyWith(description: 'New Description');
    expect(copiedProduct.description, 'New Description');
    // ... assert the rest of the properties are unchanged.
  });
  test('should copy correctly with new images list', () {
    final newImages = ['new_image1.jpg', 'new_image2.jpg'];
    final copiedProduct = tProductJsonModel.copyWith(images: newImages);
    expect(copiedProduct.images, newImages);
    // ... assert the rest of the properties are unchanged.
  });

  // Continue from the previous tests

  test('should copy correctly with new price', () {
    final copiedProduct = tProductJsonModel.copyWith(price: 200);
    expect(copiedProduct.price, 200);
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new discountPercentage', () {
    final copiedProduct = tProductJsonModel.copyWith(discountPercentage: 15);
    expect(copiedProduct.discountPercentage, 15.0);
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new rating', () {
    final copiedProduct = tProductJsonModel.copyWith(rating: 5);
    expect(copiedProduct.rating, 5.0);
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new stock', () {
    final copiedProduct = tProductJsonModel.copyWith(stock: 30);
    expect(copiedProduct.stock, 30);
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new brand', () {
    final copiedProduct = tProductJsonModel.copyWith(brand: 'New Brand');
    expect(copiedProduct.brand, 'New Brand');
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new category', () {
    final copiedProduct = tProductJsonModel.copyWith(category: 'New Category');
    expect(copiedProduct.category, 'New Category');
    // ... assert the rest of the properties are unchanged.
  });

  test('should copy correctly with new thumbnail', () {
    final copiedProduct =
        tProductJsonModel.copyWith(thumbnail: 'new_thumbnail.jpg');
    expect(copiedProduct.thumbnail, 'new_thumbnail.jpg');
    // ... assert the rest of the properties are unchanged.
  });

  test('should retain original values when not specified in copyWith', () {
    final copiedProduct = tProductJsonModel.copyWith();
    expect(copiedProduct.id, tProductJsonModel.id);
    expect(copiedProduct.title, tProductJsonModel.title);
    expect(copiedProduct.description, tProductJsonModel.description);
    expect(copiedProduct.price, tProductJsonModel.price);
    expect(
      copiedProduct.discountPercentage,
      tProductJsonModel.discountPercentage,
    );
    expect(copiedProduct.rating, tProductJsonModel.rating);
    expect(copiedProduct.stock, tProductJsonModel.stock);
    expect(copiedProduct.brand, tProductJsonModel.brand);
    expect(copiedProduct.category, tProductJsonModel.category);
    expect(copiedProduct.thumbnail, tProductJsonModel.thumbnail);
    expect(copiedProduct.images, tProductJsonModel.images);
  });
  group('toJson', () {
    test('should return product.json', () {
      // arrange
      final result = tProductJsonModel.toJson();
      // act
      expect(result, tDecodedJson);
      // assert
    });
  });
}
