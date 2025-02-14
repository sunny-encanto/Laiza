part of 'influencer_profile_bloc.dart';

sealed class InfluencerProfileState extends Equatable {
  const InfluencerProfileState();

  @override
  List<Object> get props => [];
}

final class InfluencerProfileInitial extends InfluencerProfileState {}

final class InfluencerProfileLoading extends InfluencerProfileState {}

final class InfluencerProfileLoaded extends InfluencerProfileState {
  final InfluencerProfileModel influencerProfileModel;

  const InfluencerProfileLoaded(this.influencerProfileModel);

  @override
  List<Object> get props => [influencerProfileModel];
}

final class InfluencerProfileError extends InfluencerProfileState {
  final String message;

  const InfluencerProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class InfluencerProfileToggleFollowState extends InfluencerProfileState {
  final bool isFollowed;

  const InfluencerProfileToggleFollowState(this.isFollowed);

  @override
  List<Object> get props => [isFollowed];
}
