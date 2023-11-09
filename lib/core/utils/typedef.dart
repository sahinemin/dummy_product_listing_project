import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/exception.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:http/http.dart';

typedef ApiCallResult<T> = Future<Either<Failure, T>>;

final class ApiRequest {
  static ApiCallResult<T> makeRequest<T>(
    Future<T> Function() request,
  ) async {
    try {
      return Right(await request());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    }
  }
}
