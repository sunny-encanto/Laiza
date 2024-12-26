import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/user_repository/user_repository.dart';
import 'package:laiza/data/services/media_services.dart';

import '../../../../data/models/common_model/common_model.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository;

  EditProfileBloc(this._userRepository) : super(EditProfileInitial()) {
    on<ProfileUpdateEvent>(_onProfileUpdate);
    on<ProfilePhotoChangeEvent>(_onProfileChange);
    on<FetchProfileEvent>(_onProfileFetched);
    on<BgPhotoChangeEvent>(_onBgChange);
  }

  FutureOr<void> _onProfileUpdate(
      ProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    try {
      emit(EditProfileLoadingState());
      CommonModel model = await _userRepository.updateUserProfile(event._user);
      emit(EditProfileSuccessState(model.message ?? ''));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  FutureOr<void> _onProfileChange(
      ProfilePhotoChangeEvent event, Emitter<EditProfileState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(ProfilePhotoChangedState(imagePath));
    }
  }

  FutureOr<void> _onBgChange(
      BgPhotoChangeEvent event, Emitter<EditProfileState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(BgPhotoChangedState(imagePath));
    }
  }

  FutureOr<void> _onProfileFetched(
      FetchProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(ProfileFetchLoadingState());
    UserModel user = await _userRepository.getUserProfile();
    emit(ProfileFetchedState(user));
  }
}
