part of 'collection_bloc.dart';

sealed class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object?> get props => [];
}

class FetchCollection extends CollectionEvent {}

class FetchCollectionDetails extends CollectionEvent {
  final int id;

  const FetchCollectionDetails(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteCollection extends CollectionEvent {
  final int id;

  const DeleteCollection(this.id);

  @override
  List<Object?> get props => [id];
}
