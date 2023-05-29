import 'package:dummy_clean_project/core/constants.dart';
import 'package:dummy_clean_project/core/error/failures.dart';

class FailureMap {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ClientFailure:
        return AppConstants.clientFailureMessage;
      case ServerFailure:
        return AppConstants.serverFailureMessage;
      case NetworkFailure:
        return AppConstants.networkFailureMessage;
      default:
        return AppConstants.unexpectedErrorMessage;
    }
  }
}
