part of 'reel_bloc.dart';

sealed class ReelEvent extends Equatable {
  const ReelEvent();

  @override
  List<Object> get props => [];
}

class LoadReels extends ReelEvent {
  final List<String> reelUrls;

  const LoadReels(this.reelUrls);

  @override
  List<Object> get props => [reelUrls];
}

class ChangeReelPage extends ReelEvent {
  final int page;

  const ChangeReelPage(this.page);

  @override
  List<Object> get props => [page];
}

class ReelFollowRequestEvent extends ReelEvent {
  final bool isFollowed;
  const ReelFollowRequestEvent(this.isFollowed);
  @override
  List<Object> get props => [isFollowed];
}
