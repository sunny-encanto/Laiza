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
  final int parentId;

  const CommentLikeUnLikeEvent({required this.id, required this.parentId});

  @override
  List<Object> get props => [id, parentId];
}

class AddCommentEvent extends CommentsEvent {
  final int reelId;
  final String comment;

  const AddCommentEvent({required this.reelId, required this.comment});

  @override
  List<Object> get props => [reelId, comment];
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
  final int parentId;

  const DeleteCommentEvent({required this.commentId, required this.parentId});

  @override
  List<Object> get props => [commentId, parentId];
}

class DeleteSubCommentEvent extends CommentsEvent {
  final int commentId;

  const DeleteSubCommentEvent(this.commentId);

  @override
  List<Object> get props => [commentId];
}

class EditCommentEvent extends CommentsEvent {
  final int commentId;
  final int reelId;
  final String comment;

  const EditCommentEvent(
      {required this.commentId, required this.comment, required this.reelId});

  @override
  List<Object> get props => [commentId, comment, reelId];
}
