part of 'upload_reel_bloc.dart';

sealed class UploadReelEvent extends Equatable {
  const UploadReelEvent();

  @override
  List<Object> get props => [];
}

class AddCoverPhotoEvent extends UploadReelEvent {}

class AddMoreProductLinkEvent extends UploadReelEvent {}

final class UploadReelSubmitRequestEvent extends UploadReelEvent {
  final String reelTitle;
  final int productId;
  final String reelDes;
  final String reelPath;

  final int categoryId;

  final String coverPath;
  final String hashTag;

  const UploadReelSubmitRequestEvent(
      {required this.reelTitle,
      required this.productId,
      required this.reelDes,
      required this.reelPath,
      required this.categoryId,
      required this.coverPath,
      required this.hashTag});

  @override
  List<Object> get props => [reelTitle, productId, reelDes, reelPath];
}
