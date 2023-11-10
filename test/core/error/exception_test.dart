import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServerException', () {
    test('props should return the correct list of properties', () {
      const exception = ServerException('Server error', 500);
      expect(exception.props, ['Server error', 500]);
    });

    test('should equate two instances with identical properties', () {
      const exception1 = ServerException('Server error', 500);
      const exception2 = ServerException('Server error', 500);
      expect(exception1, equals(exception2));
    });

    test('should not equate two instances with different properties', () {
      const exception1 = ServerException('Server error', 500);
      const exception2 = ServerException('Another error', 404);
      expect(exception1, isNot(equals(exception2)));
    });
  });

  group('NetworkException', () {
    test('props should return the correct list of properties', () {
      const exception = NetworkException();
      expect(exception.props, ['No Internet Connection', 0]);
    });

    test('should equate two instances with identical properties', () {
      const exception1 = NetworkException();
      const exception2 = NetworkException();
      expect(exception1, equals(exception2));
    });

    test('should not equate two instances with different properties', () {
      const exception1 = NetworkException();
      const exception2 = NetworkException(message: 'Timeout', statusCode: 408);
      expect(exception1, isNot(equals(exception2)));
    });
  });
}
