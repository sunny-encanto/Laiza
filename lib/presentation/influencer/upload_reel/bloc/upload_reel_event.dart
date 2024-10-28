part of 'upload_reel_bloc.dart';

sealed class UploadReelEvent extends Equatable {
  const UploadReelEvent();

  @override
  List<Object> get props => [];
}

class AddCoverPhotoEvent extends UploadReelEvent {}

class AddMoreProductLinkEvent extends UploadReelEvent {}

final class UploadReelSubmitRequestEvent extends UploadReelEvent {}
