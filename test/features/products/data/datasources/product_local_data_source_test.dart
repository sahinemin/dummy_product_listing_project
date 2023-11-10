import 'dart:convert';

import 'package:dummy_clean_project/features/products/data/datasources/product_local_data_source.dart';
import 'package:dummy_clean_project/features/products/data/models/product_json_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('ProductLocalDataSourceImpl', () {
    late MockSharedPreferences mockSharedPreferences;
    late ProductLocalDataSourceImpl dataSource;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      dataSource = ProductLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    });
    final testProductList = [const ProductJsonModel.test()];

    group('cacheProductList', () {
      test('should call SharedPreferences to cache the data', () async {
        // Arrange

        when(() => mockSharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        // Act
        await dataSource.cacheProductList(testProductList);

        // Assert
        final expectedJsonString = jsonEncode(testProductList);
        verify(
          () => mockSharedPreferences.setString(
            cachedProductList,
            expectedJsonString,
          ),
        ).called(1);
      });
    });

    group('getCachedProductList', () {
      test(
          'should return a list of ProductJsonModel from '
          'SharedPreferences when there is cached data', () {
        // Arrange

        final jsonString = jsonEncode(testProductList);
        when(() => mockSharedPreferences.containsKey(any())).thenReturn(true);
        when(() => mockSharedPreferences.getString(any()))
            .thenReturn(jsonString);

        // Act
        final result = dataSource.getCachedProductList();

        // Assert
        expect(result, isA<List<ProductJsonModel>>());
        expect(result, equals(testProductList));
      });

      test('should return null when there is no cached data', () {
        // Arrange
        when(() => mockSharedPreferences.containsKey(any())).thenReturn(false);

        // Act
        final result = dataSource.getCachedProductList();

        // Assert
        expect(result, isNull);
      });
    });

    group('hasCachedProductList', () {
      test('should return true when there is cached data', () {
        // Arrange
        when(() => mockSharedPreferences.containsKey(any())).thenReturn(true);

        // Act
        final result = dataSource.hasCachedProductList;

        // Assert
        expect(result, isTrue);
      });

      test('should return false when there is no cached data', () {
        // Arrange
        when(() => mockSharedPreferences.containsKey(any())).thenReturn(false);

        // Act
        final result = dataSource.hasCachedProductList;

        // Assert
        expect(result, isFalse);
      });
    });
  });
}
