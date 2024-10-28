part of 'upload_reel_bloc.dart';

sealed class UploadReelState extends Equatable {
  const UploadReelState();

  @override
  List<Object> get props => [];
}

final class UploadReelCoverPhotoSelectedSate extends UploadReelState {
  final String imagePath;
  const UploadReelCoverPhotoSelectedSate(this.imagePath);
  @override
  List<Object> get props => [imagePath];
}

final class UploadReelInitial extends UploadReelState {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  const UploadReelInitial(
      {required this.controllers, required this.focusNodes});

  @override
  List<Object> get props => [controllers, focusNodes];
}

final class UploadReelLoadingSate extends UploadReelState {}

final class UploadReelErrorState extends UploadReelState {
  final String message;
  const UploadReelErrorState(this.message);
  @override
  List<Object> get props => [message];
}

final class UploadReelSuccessState extends UploadReelState {}
