part of 'influence_profile_setup_bloc.dart';

sealed class InfluenceProfileSetupEvent extends Equatable {
  const InfluenceProfileSetupEvent();

  @override
  List<Object> get props => [];
}

class InfluencerProfileSetupSubmitRequest extends InfluenceProfileSetupEvent {
  final String imagePath;
  final String bio;
  const InfluencerProfileSetupSubmitRequest(
      {required this.imagePath, required this.bio});
  @override
  List<Object> get props => [imagePath, bio];
}

class InfluencerImageUploadEvent extends InfluenceProfileSetupEvent {}
