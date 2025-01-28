part of 'favorite_influencers_bloc.dart';

sealed class FavoriteInfluencersState extends Equatable {
  const FavoriteInfluencersState();

  @override
  List<Object> get props => [];
}

final class FavoriteInfluencersInitial extends FavoriteInfluencersState {}

final class FavoriteInfluencersLoading extends FavoriteInfluencersState {}

final class FavoriteInfluencersLoaded extends FavoriteInfluencersState {
  final List favInfluencers;

  const FavoriteInfluencersLoaded(this.favInfluencers);

  @override
  List<Object> get props => [favInfluencers];
}

final class FavoriteInfluencersError extends FavoriteInfluencersState {
  final String message;

  const FavoriteInfluencersError(this.message);

  @override
  List<Object> get props => [message];
}
