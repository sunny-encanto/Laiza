part of 'trending_now_bloc.dart';

sealed class TrendingNowEvent extends Equatable {
  const TrendingNowEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingNowEvent extends TrendingNowEvent {}
