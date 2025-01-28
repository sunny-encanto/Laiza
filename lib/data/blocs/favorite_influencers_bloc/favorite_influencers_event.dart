part of 'favorite_influencers_bloc.dart';

sealed class FavoriteInfluencersEvent extends Equatable {
  const FavoriteInfluencersEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavInfluencersEvent extends FavoriteInfluencersEvent {}
