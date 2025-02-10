part of 'reel_from_followed_influencer_bloc.dart';

sealed class ReelFromFollowedInfluencerState extends Equatable {
  const ReelFromFollowedInfluencerState();

  @override
  List<Object> get props => [];
}

final class ReelFromFollowedInfluencerInitial
    extends ReelFromFollowedInfluencerState {}

final class ReelFromFollowedInfluencerLoading
    extends ReelFromFollowedInfluencerState {}

final class ReelFromFollowedInfluencerLoaded
    extends ReelFromFollowedInfluencerState {
  final List<Reel> reel;

  const ReelFromFollowedInfluencerLoaded(this.reel);

  @override
  List<Object> get props => [reel];
}

final class ReelFromFollowedInfluencerError
    extends ReelFromFollowedInfluencerState {
  final String message;

  const ReelFromFollowedInfluencerError(this.message);

  @override
  List<Object> get props => [message];
}
