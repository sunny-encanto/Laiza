import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/services/media_services.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<ProfileUpdateEvent>(_onProfileUpdate);
    on<ProfilePhotoChangeEvent>(_onProfileChange);
  }

  FutureOr<void> _onProfileUpdate(
      ProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(EditProfileSuccessState());
  }

  FutureOr<void> _onProfileChange(
      ProfilePhotoChangeEvent event, Emitter<EditProfileState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(ProfilePhotoChangedState(imagePath));
    }
  }
}
