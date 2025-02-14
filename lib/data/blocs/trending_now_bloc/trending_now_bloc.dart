import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/trending_items_model/trending_items_model.dart';

part 'trending_now_event.dart';
part 'trending_now_state.dart';

class TrendingNowBloc extends Bloc<TrendingNowEvent, TrendingNowState> {
  final PostRepository _postRepository;
  List<TrendingItems> items = <TrendingItems>[];

  TrendingNowBloc(this._postRepository) : super(TrendingNowInitial()) {
    on<FetchTrendingNowEvent>(_onFetchTrendingNow);
    on<ToggleTrendingNowEvent>(_onToggleTrendingNow);
  }

  FutureOr<void> _onFetchTrendingNow(
      FetchTrendingNowEvent event, Emitter<TrendingNowState> emit) async {
    try {
      emit(TrendingNowLoading());
      items = await _postRepository.getTrendingItems();
      emit(TrendingNowLoaded(items));
    } catch (e) {
      emit(TrendingNowError(e.toString()));
    }
  }

  FutureOr<void> _onToggleTrendingNow(
      ToggleTrendingNowEvent event, Emitter<TrendingNowState> emit) async {
    try {
      emit(TrendingNowLoading());
      items = items.map((item) {
        print('Event id ${event.id} item id ${item.id}');
        if (item.id == event.id) {
          return item.copyWith(isLike: item.isLike == 0 ? 1 : 0);
        }
        return item;
      }).toList();
      emit(TrendingNowLoaded(items));
    } catch (e) {
      emit(TrendingNowError(e.toString()));
    }
  }
}
