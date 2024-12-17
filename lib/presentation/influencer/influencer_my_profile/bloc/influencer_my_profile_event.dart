part of 'influencer_my_profile_bloc.dart';

sealed class InfluencerMyProfileEvent extends Equatable {
  const InfluencerMyProfileEvent();

  @override
  List<Object> get props => [];
}

class OnInstagramIconTap extends InfluencerMyProfileEvent {}

class OnXIconTap extends InfluencerMyProfileEvent {}

class OnFBIconTap extends InfluencerMyProfileEvent {}

class OnSnapIconTap extends InfluencerMyProfileEvent {}
