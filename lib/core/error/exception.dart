import 'package:equatable/equatable.dart';

final class ServerException extends Equatable implements Exception {
  const ServerException(this.message, this.statusCode);
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

final class NetworkException extends Equatable implements Exception {
  const NetworkException({
    this.message = 'No Internet Connection',
    this.statusCode = 0,
  });
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
