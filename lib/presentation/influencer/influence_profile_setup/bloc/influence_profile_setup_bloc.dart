import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/services/media_services.dart';

part 'influence_profile_setup_event.dart';
part 'influence_profile_setup_state.dart';

class InfluenceProfileSetupBloc
    extends Bloc<InfluenceProfileSetupEvent, InfluenceProfileSetupState> {
  InfluenceProfileSetupBloc() : super(InfluenceProfileSetupInitial()) {
    on<InfluencerProfileSetupSubmitRequest>(_onSubmitRequest);
    on<InfluencerImageUploadEvent>(_onImageUpload);
  }

  FutureOr<void> _onSubmitRequest(InfluencerProfileSetupSubmitRequest event,
      Emitter<InfluenceProfileSetupState> emit) async {
    emit(InfluenceProfileSetupLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (event.imagePath.isEmpty) {
      emit(const InfluenceProfileSetupError('Please upload Image'));
    } else {
      emit(InfluenceProfileSetupSuccess());
    }
  }

  FutureOr<void> _onImageUpload(InfluencerImageUploadEvent event,
      Emitter<InfluenceProfileSetupState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(InfluenceImageUploadedState(imagePath));
    }
  }
}
