part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfilePhotoChangeEvent extends EditProfileEvent {}

class ProfileUpdateEvent extends EditProfileEvent {}
