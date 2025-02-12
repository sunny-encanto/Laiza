part of 'collection_bloc.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

final class CollectionInitial extends CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionLoaded extends CollectionState {
  final List<Collection> collection;

  const CollectionLoaded(this.collection);

  @override
  List<Object> get props => [collection];
}

final class CollectionError extends CollectionState {
  final String message;

  const CollectionError(this.message);

  @override
  List<Object> get props => [message];
}

final class CollectionDeleteSuccess extends CollectionState {
  final String message;

  const CollectionDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}
