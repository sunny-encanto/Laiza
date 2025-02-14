part of 'influencer_profile_bloc.dart';

sealed class InfluencerProfileEvent extends Equatable {
  const InfluencerProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchInfluencerProfileEvent extends InfluencerProfileEvent {
  final String id;

  const FetchInfluencerProfileEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class InfluencerProfileToggleFollowEvent extends InfluencerProfileEvent {
  final String id;
  final bool isFollowed;

  const InfluencerProfileToggleFollowEvent(
      {required this.id, required this.isFollowed});

  @override
  List<Object?> get props => [id, isFollowed];
}
