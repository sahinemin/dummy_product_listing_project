import 'package:chopper/chopper.dart';
import 'package:dummy_clean_project/core/client/app_client.dart';
import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/features/products/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppClient', () {
    final appClient = AppClient();
    test('should be initialized with correct values', () {
      // Arrange & Act
      // Assert
      expect(appClient.baseUrl, Uri.parse(AppConstants.kbaseUrl));
      expect(appClient.converter, isA<JsonConverter>());
    });

    // Additional tests to verify that each service is added correctly
    test('should contain ProductService', () {
      // Act
      final productService = appClient.getService<ProductService>();
      // Assert
      expect(productService, isNotNull);
      expect(productService, isA<ProductService>());
    });

  });
}
