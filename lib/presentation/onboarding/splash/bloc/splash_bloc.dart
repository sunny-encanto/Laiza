import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
      SplashStarted event, Emitter<SplashState> emit) async {
    // Simulate loading time, e.g., fetching some data or checking authentication
    await Future.delayed(const Duration(seconds: 7));
    // Emit SplashSuccess state after delay
    emit(const SplashSuccess());
  }
}
