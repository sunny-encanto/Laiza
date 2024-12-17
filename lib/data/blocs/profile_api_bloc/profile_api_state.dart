part of 'profile_api_bloc.dart';

sealed class ProfileApiState extends Equatable {
  const ProfileApiState();

  @override
  List<Object> get props => [];
}

final class ProfileApiInitial extends ProfileApiState {}

final class ProfileApiLoadingState extends ProfileApiState {}

final class ProfileApiError extends ProfileApiState {
  final String message;

  const ProfileApiError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProfileApiLoadedState extends ProfileApiState {
  final UserModel userModel;

  const ProfileApiLoadedState(this.userModel);

  @override
  List<Object> get props => [userModel];
}
