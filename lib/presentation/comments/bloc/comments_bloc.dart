import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/comments_model/comments_model.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentLoadEvent>(_onCommentLoad);
    on<CommentLikeUnLikeEvent>(_onCommentLikeUnlike);
  }

  FutureOr<void> _onCommentLoad(
      CommentLoadEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    await Future.delayed(const Duration(seconds: 1));
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
}
