part of 'reel_from_followed_influencer_bloc.dart';

sealed class ReelFromFollowedInfluencerEvent extends Equatable {
  const ReelFromFollowedInfluencerEvent();

  @override
  List<Object?> get props => [];
}

final class FetchReelFromFollowedInfluencer
    extends ReelFromFollowedInfluencerEvent {}
