import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trending_now_event.dart';
part 'trending_now_state.dart';

class TrendingNowBloc extends Bloc<TrendingNowEvent, TrendingNowState> {
  TrendingNowBloc() : super(TrendingNowInitial()) {
    on<FetchTrendingNowEvent>(_onFetchTrendingNow);
  }

  FutureOr<void> _onFetchTrendingNow(
      FetchTrendingNowEvent event, Emitter<TrendingNowState> emit) async {
    try {
      emit(TrendingNowLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(const TrendingNowLoaded([]));
    } catch (e) {
      emit(TrendingNowError(e.toString()));
    }
  }
}
