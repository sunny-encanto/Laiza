part of 'comments_bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsErrorState extends CommentsState {
  final String message;

  const CommentsErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

final class CommentDeletedState extends CommentsState {
  final String message;

  const CommentDeletedState(this.message);

  @override
  List<Object> get props => [message];
}

final class CommentDeleteErrorState extends CommentsState {
  final String message;

  const CommentDeleteErrorState(this.message);

  @override
  List<Object> get props => [message];
}
