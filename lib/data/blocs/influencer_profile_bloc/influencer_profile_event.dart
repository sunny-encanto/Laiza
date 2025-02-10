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
