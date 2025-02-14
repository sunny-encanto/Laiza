part of 'trending_now_bloc.dart';

sealed class TrendingNowEvent extends Equatable {
  const TrendingNowEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingNowEvent extends TrendingNowEvent {}

class ToggleTrendingNowEvent extends TrendingNowEvent {
  final int id;

  const ToggleTrendingNowEvent(this.id);

  @override
  List<Object?> get props => [id];
}
