part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CommentLoadEvent extends CommentsEvent {
  final int reelId;

  const CommentLoadEvent(this.reelId);

  @override
  List<Object> get props => [reelId];
}

class CommentLikeUnLikeEvent extends CommentsEvent {
  final int id;

  const CommentLikeUnLikeEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddCommentEvent extends CommentsEvent {
  final int reelId;
  final String comment;

  const AddCommentEvent({required this.reelId, required this.comment});

  @override
  List<Object> get props => [reelId, comment];
}

class CommentReplyLoadEvent extends CommentsEvent {
  final int commentId;

  const CommentReplyLoadEvent(this.commentId);

  @override
  List<Object> get props => [commentId];
}

class AddCommentReplyEvent extends CommentsEvent {
  final int commentId;
  final String reply;

  const AddCommentReplyEvent({required this.commentId, required this.reply});

  @override
  List<Object> get props => [commentId, reply];
}

class DeleteCommentEvent extends CommentsEvent {
  final int commentId;

  const DeleteCommentEvent(this.commentId);

  @override
  List<Object> get props => [commentId];
}
