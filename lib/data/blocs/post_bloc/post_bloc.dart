import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/post_model/post_model.dart';
import '../../repositories/post_repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPostsEvent>(onFetchPost);
  }
  PostRepository postRepository;

  FutureOr<void> onFetchPost(event, emit) async {
    try {
      emit(PostLoading());
      final posts = await postRepository.fetchPosts();
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
