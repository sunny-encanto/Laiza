part of 'upload_reel_bloc.dart';

sealed class UploadReelEvent extends Equatable {
  const UploadReelEvent();

  @override
  List<Object> get props => [];
}

class AddCoverPhotoEvent extends UploadReelEvent {}

class AddReelEvent extends UploadReelEvent {}

class AddMoreProductLinkEvent extends UploadReelEvent {}

final class UploadReelSubmitRequestEvent extends UploadReelEvent {
  final String reelTitle;
  final List<String> productIds;
  final String reelDes;
  final String reelPath;
  final String coverPath;
  final String hashTag;

  const UploadReelSubmitRequestEvent(
      {required this.reelTitle,
      required this.productIds,
      required this.reelDes,
      required this.reelPath,
      required this.coverPath,
      required this.hashTag});

  @override
  List<Object> get props => [reelTitle, productIds, reelDes, reelPath];
}

class UpdateReelRequestEvent extends UploadReelEvent {
  final Reel reel;

  const UpdateReelRequestEvent(this.reel);

  @override
  List<Object> get props => [reel];
}
