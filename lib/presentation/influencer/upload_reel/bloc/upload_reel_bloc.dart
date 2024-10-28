import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../../../core/app_export.dart';
import '../../../../data/services/media_services.dart';

part 'upload_reel_event.dart';
part 'upload_reel_state.dart';

class UploadReelBloc extends Bloc<UploadReelEvent, UploadReelState> {
  UploadReelBloc()
      : super(UploadReelInitial(
            controllers: [TextEditingController()],
            focusNodes: [FocusNode()])) {
    on<UploadReelSubmitRequestEvent>(_onSubmitRequest);
    on<AddMoreProductLinkEvent>(_onAddMoreProductLink);
    on<AddCoverPhotoEvent>(_onAddCoverPhotoAdded);
  }

  FutureOr<void> _onAddMoreProductLink(
      AddMoreProductLinkEvent event, Emitter<UploadReelState> emit) {
    final currentState = state as UploadReelInitial;

    // Create new TextEditingController and FocusNode
    final newController = TextEditingController();
    final newFocusNode = FocusNode();

    // Add them to the lists
    final updatedControllers =
        List<TextEditingController>.from(currentState.controllers)
          ..add(newController);
    final updatedFocusNodes = List<FocusNode>.from(currentState.focusNodes)
      ..add(newFocusNode);

    // Emit new state with updated controllers and focus nodes
    emit(UploadReelInitial(
        controllers: updatedControllers, focusNodes: updatedFocusNodes));
  }

  FutureOr<void> _onSubmitRequest(
      UploadReelSubmitRequestEvent event, Emitter<UploadReelState> emit) async {
    emit(UploadReelLoadingSate());
    await Future.delayed(const Duration(seconds: 1));
    emit(UploadReelSuccessState());
  }

  FutureOr<void> _onAddCoverPhotoAdded(
      AddCoverPhotoEvent event, Emitter<UploadReelState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(UploadReelCoverPhotoSelectedSate(imagePath));
    }
  }
}
