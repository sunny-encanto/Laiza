part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  const PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String message;
  const PostError({required this.message});
}
