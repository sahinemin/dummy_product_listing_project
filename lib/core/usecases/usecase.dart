import 'package:dartz/dartz.dart';
import 'package:dummy_clean_project/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParameters extends Equatable {
  @override
  List<Object?> get props => [];
}
