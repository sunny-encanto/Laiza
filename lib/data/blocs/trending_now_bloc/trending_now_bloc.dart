import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/trending_items_model/trending_items_model.dart';

part 'trending_now_event.dart';
part 'trending_now_state.dart';

class TrendingNowBloc extends Bloc<TrendingNowEvent, TrendingNowState> {
  final PostRepository _postRepository;

  TrendingNowBloc(this._postRepository) : super(TrendingNowInitial()) {
    on<FetchTrendingNowEvent>(_onFetchTrendingNow);
  }

  FutureOr<void> _onFetchTrendingNow(
      FetchTrendingNowEvent event, Emitter<TrendingNowState> emit) async {
    try {
      emit(TrendingNowLoading());
      List<TrendingItems> items = await _postRepository.getTrendingItems();
      emit(TrendingNowLoaded(items));
    } catch (e) {
      emit(TrendingNowError(e.toString()));
    }
  }
}
