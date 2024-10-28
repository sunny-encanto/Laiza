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
}

final class CommentsLoaded extends CommentsState {
  final List<CommentModel> comments;
  const CommentsLoaded(this.comments);
  @override
  List<Object> get props => [comments];
}
