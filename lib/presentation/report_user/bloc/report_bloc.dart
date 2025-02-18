import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'report_event.dart';
import 'report_user_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<SubmitReport>(_onSubmit);
  }

  FutureOr<void> _onSubmit(
      SubmitReport event, Emitter<ReportState> emit) async {
    print('Submit');
    try {
      emit(ReportLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure(e.toString()));
    }
  }
}
