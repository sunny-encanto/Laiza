part of 'create_collection_bloc.dart';

sealed class CreateCollectionState extends Equatable {
  const CreateCollectionState();

  @override
  List<Object> get props => [];
}

final class CreateCollectionInitial extends CreateCollectionState {}

final class CreateCollectionLoading extends CreateCollectionState {}

final class CreateCollectionError extends CreateCollectionState {
  final String message;
  const CreateCollectionError(this.message);
  @override
  List<Object> get props => [message];
}

final class CreateCollectionLoaded extends CreateCollectionState {
  final List<Post> collection;
  const CreateCollectionLoaded(this.collection);
  @override
  List<Object> get props => [collection];
}
