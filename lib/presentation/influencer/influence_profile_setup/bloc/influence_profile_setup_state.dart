part of 'influence_profile_setup_bloc.dart';

sealed class InfluenceProfileSetupState extends Equatable {
  const InfluenceProfileSetupState();

  @override
  List<Object> get props => [];
}

final class InfluenceImageUploadedState extends InfluenceProfileSetupState {
  final String imagePath;
  const InfluenceImageUploadedState(this.imagePath);
  @override
  List<Object> get props => [imagePath];
}

final class InfluenceProfileSetupInitial extends InfluenceProfileSetupState {}

final class InfluenceProfileSetupLoading extends InfluenceProfileSetupState {}

final class InfluenceProfileSetupError extends InfluenceProfileSetupState {
  final String message;
  const InfluenceProfileSetupError(this.message);
  @override
  List<Object> get props => [];
}

final class InfluenceProfileSetupSuccess extends InfluenceProfileSetupState {}
