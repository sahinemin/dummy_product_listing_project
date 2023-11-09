import 'package:chopper/chopper.dart';
import 'package:mocktail/mocktail.dart';

final class MockResponse extends Mock
    with MockResponseMixin<Map<String, dynamic>> {}
