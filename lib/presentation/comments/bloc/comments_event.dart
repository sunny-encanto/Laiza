part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CommentLoadEvent extends CommentsEvent {}

class CommentLikeUnLikeEvent extends CommentsEvent {
  final int id;
  const CommentLikeUnLikeEvent(this.id);
  @override
  List<Object> get props => [id];
}
