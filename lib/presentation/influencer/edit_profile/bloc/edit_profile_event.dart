part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends EditProfileEvent {}

class ProfilePhotoChangeEvent extends EditProfileEvent {}

class ProfileUpdateEvent extends EditProfileEvent {
  final UserModel _user;
  const ProfileUpdateEvent(this._user);
  @override
  List<Object> get props => [_user];
}
