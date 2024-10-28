import 'package:connectivity_plus/connectivity_plus.dart';

// For checking internet connectivity
abstract class NetworkInfoI {
  Future<bool> isConnected();

  Future<ConnectivityResult> get connectivityResult;

  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfo {
  Connectivity connectivity;

  NetworkInfo(this.connectivity) {
    connectivity = connectivity;
  }

  ///checks internet is connected or not
  ///returns [true] if internet is connected
  ///else it will return [false]

  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    if (!result.contains(ConnectivityResult.none)) {
      return true;
    }
    return false;
  }
}
