import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/comments_repository/comments_repository.dart';

import '../../../data/models/comments_model/comment.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository _commentsRepository;
  List<Comment> commentList = <Comment>[];

  CommentsBloc(this._commentsRepository) : super(CommentsInitial()) {
    on<CommentLoadEvent>(_onCommentLoad);
    on<CommentLikeUnLikeEvent>(_onCommentLikeUnlike);
    on<AddCommentEvent>(_onCommentAdd);
    on<AddCommentReplyEvent>(_onAddCommentReplyEvent);
    on<CommentReplyLoadEvent>(_onCommentReplyLoad);
    on<DeleteCommentEvent>(_onDeleteComment);
  }

  FutureOr<void> _onCommentLoad(
      CommentLoadEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    commentList = await _commentsRepository.getComment(event.reelId);
    emit(CommentsLoaded(commentList));
  }

  FutureOr<void> _onCommentLikeUnlike(
      CommentLikeUnLikeEvent event, Emitter<CommentsState> emit) {
    commentList = commentList.map((item) {
      if (item.id == event.id) {
        return item.copyWith(
            isLiked: !item.isLiked,
            commentCount:
                item.isLiked ? item.commentCount - 1 : item.commentCount + 1);
      }
      return item;
    }).toList();
    emit(CommentsLoaded(commentList));
  }

  FutureOr<void> _onCommentAdd(
      AddCommentEvent event, Emitter<CommentsState> emit) async {
    await _commentsRepository.addComment(
        reelId: event.reelId, comment: event.comment);
    emit(CommentsInitial());
  }

  FutureOr<void> _onCommentReplyLoad(
      CommentReplyLoadEvent event, Emitter<CommentsState> emit) async {
    try {
      List<Comment> comments =
          await _commentsRepository.getCommentReply(event.commentId);
      emit(CommentsReplyLoaded(comments));
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  FutureOr<void> _onAddCommentReplyEvent(
      AddCommentReplyEvent event, Emitter<CommentsState> emit) async {
    try {
      await _commentsRepository.addCommentReply(
          commentId: event.commentId, reply: event.reply);
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  FutureOr<void> _onDeleteComment(
      DeleteCommentEvent event, Emitter<CommentsState> emit) async {
    try {
      CommonModel model =
          await _commentsRepository.deleteComment(event.commentId);
      emit(CommentDeletedState(model.message ?? ''));
    } catch (e) {
      emit(CommentDeleteErrorState(e.toString()));
    }
  }
}
