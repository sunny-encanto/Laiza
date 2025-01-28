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
    on<DeleteCommentEvent>(_onDeleteComment);
    on<DeleteSubCommentEvent>(_onDeleteSubComment);
    on<EditCommentEvent>(_onEditComment);
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
      if (event.parentId == 0) {
        if (item.id == event.id) {
          _commentsRepository.addCommentLike(event.id);
          return item.copyWith(
              isLiked: !item.isLiked,
              likeCount:
                  item.isLiked ? item.likeCount - 1 : item.likeCount + 1);
        }
      } else {
        if (item.id == event.parentId) {
          _commentsRepository.addSubCommentLike(event.id);
          List<Comment> replies = item.replies;
          replies = replies.map(
            (element) {
              if (element.id == event.id) {
                return element.copyWith(
                    isLiked: !element.isLiked,
                    likeCount: element.isLiked
                        ? element.likeCount - 1
                        : element.likeCount + 1);
              }
              return element;
            },
          ).toList();
          return item.copyWith(replies: replies);
        }
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

  FutureOr<void> _onAddCommentReplyEvent(
      AddCommentReplyEvent event, Emitter<CommentsState> emit) async {
    try {
      await _commentsRepository.addCommentReply(
          commentId: event.commentId, reply: event.reply);
      emit(CommentsInitial());
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  FutureOr<void> _onDeleteComment(
      DeleteCommentEvent event, Emitter<CommentsState> emit) async {
    try {
      CommonModel model = event.parentId == 0
          ? await _commentsRepository.deleteComment(event.commentId)
          : await _commentsRepository.deleteSubComment(event.commentId);
      emit(CommentDeletedState(model.message ?? ''));
    } catch (e) {
      emit(CommentDeleteErrorState(e.toString()));
    }
  }

  FutureOr<void> _onEditComment(
      EditCommentEvent event, Emitter<CommentsState> emit) async {
    try {
      await _commentsRepository.updateComment(
          commentId: event.commentId,
          comment: event.comment,
          reelId: event.reelId);
      emit(CommentsInitial());
    } catch (e) {
      emit(CommentsErrorState(e.toString()));
    }
  }

  FutureOr<void> _onDeleteSubComment(
      DeleteSubCommentEvent event, Emitter<CommentsState> emit) async {
    try {
      CommonModel model =
          await _commentsRepository.deleteComment(event.commentId);
      emit(CommentDeletedState(model.message ?? ''));
    } catch (e) {
      emit(CommentDeleteErrorState(e.toString()));
    }
  }
}
