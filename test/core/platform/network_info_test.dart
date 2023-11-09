import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dummy_clean_project/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('should forward the call to Connectivity.checkConnectivity()',
        () async {
      // Arrange
      final tHasConnectionFuture = Future.value(ConnectivityResult.wifi);

      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => tHasConnectionFuture);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      expect(result, true);
    });

    test('should return false when there is no internet connection', () async {
      // Arrange
      final tNoConnectionFuture = Future.value(ConnectivityResult.none);

      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => tNoConnectionFuture);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      expect(result, false);
    });
  });
}
