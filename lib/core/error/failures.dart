import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message, {this.statusCode});
  final String message;
  final int? statusCode;
  @override
  List<Object?> get props {
    return [message, statusCode];
  }

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class ClientFailure extends Failure {
  const ClientFailure(super.message, {super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.statusCode});
}
