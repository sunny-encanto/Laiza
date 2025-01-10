import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../../../../core/app_export.dart';
import '../../../../data/services/media_services.dart';

part 'upload_reel_event.dart';
part 'upload_reel_state.dart';

class UploadReelBloc extends Bloc<UploadReelEvent, UploadReelState> {
  final ReelRepository _reelRepository;

  UploadReelBloc(this._reelRepository)
      : super(UploadReelInitial(
            controllers: [TextEditingController()],
            focusNodes: [FocusNode()])) {
    on<UploadReelSubmitRequestEvent>(_onSubmitRequest);
    on<AddMoreProductLinkEvent>(_onAddMoreProductLink);
    on<AddCoverPhotoEvent>(_onAddCoverPhotoAdded);
    on<UpdateReelRequestEvent>(_onUpdateReel);
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
    try {
      emit(UploadReelLoadingSate());
      CommonModel responseData = await _reelRepository.addReel(
        productId: event.productId,
        reelTitle: event.reelTitle,
        reelPath: event.reelPath,
        categoryId: event.categoryId,
        reelDes: event.reelDes,
        coverPath: event.coverPath,
        hashTag: event.hashTag,
      );

      emit(UploadReelSuccessState(responseData.message ?? ""));
    } catch (e) {
      emit(UploadReelErrorState(e.toString()));
    }
  }

  FutureOr<void> _onAddCoverPhotoAdded(
      AddCoverPhotoEvent event, Emitter<UploadReelState> emit) async {
    String? imagePath = await MediaServices.pickImageFromGallery();
    if (imagePath != null) {
      emit(UploadReelCoverPhotoSelectedSate(imagePath));
    }
  }

  FutureOr<void> _onUpdateReel(
      UpdateReelRequestEvent event, Emitter<UploadReelState> emit) async {
    try {
      emit(UploadReelLoadingSate());
      CommonModel responseData = await _reelRepository.updateReel(event.reel);
      emit(UploadReelSuccessState(responseData.message ?? ""));
    } catch (e) {
      emit(UploadReelErrorState(e.toString()));
    }
  }
}
