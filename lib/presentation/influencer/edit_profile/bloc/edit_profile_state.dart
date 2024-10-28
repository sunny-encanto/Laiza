part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {}

final class EditProfileError extends EditProfileState {
  final String message;
  const EditProfileError(this.message);
  @override
  List<Object> get props => [message];
}

final class EditProfileSuccessState extends EditProfileState {}

final class ProfilePhotoChangedState extends EditProfileState {
  final String imagePath;
  const ProfilePhotoChangedState(this.imagePath);
  @override
  List<Object> get props => [imagePath];
}
