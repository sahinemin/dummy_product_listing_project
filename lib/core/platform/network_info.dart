import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

final class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);
  final Connectivity connectionChecker;
  @override
  Future<bool> get isConnected => connectionChecker
      .checkConnectivity()
      .then((result) => result != ConnectivityResult.none);
}
