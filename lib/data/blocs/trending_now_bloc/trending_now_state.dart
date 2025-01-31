part of 'trending_now_bloc.dart';

sealed class TrendingNowState extends Equatable {
  const TrendingNowState();

  @override
  List<Object> get props => [];
}

final class TrendingNowInitial extends TrendingNowState {}

final class TrendingNowLoading extends TrendingNowState {}

final class TrendingNowLoaded extends TrendingNowState {
  final List<TrendingItems> trendingNow;

  const TrendingNowLoaded(this.trendingNow);

  @override
  List<Object> get props => [trendingNow];
}

final class TrendingNowError extends TrendingNowState {
  final String message;

  const TrendingNowError(this.message);

  @override
  List<Object> get props => [message];
}
