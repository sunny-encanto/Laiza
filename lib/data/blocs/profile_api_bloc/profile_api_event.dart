part of 'profile_api_bloc.dart';

sealed class ProfileApiEvent extends Equatable {
  const ProfileApiEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileApi extends ProfileApiEvent {}
