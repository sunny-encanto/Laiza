import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityCubit(this._connectivity)
      : super(ConnectivityStatus.disconnected) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (!result.contains(ConnectivityResult.none)) {
        emit(ConnectivityStatus.connected);
      } else {
        emit(ConnectivityStatus.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
