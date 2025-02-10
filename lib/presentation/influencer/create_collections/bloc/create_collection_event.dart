part of 'create_collection_bloc.dart';

sealed class CreateCollectionEvent extends Equatable {
  const CreateCollectionEvent();

  @override
  List<Object> get props => [];
}

class CollectionFetchEvent extends CreateCollectionEvent {}

class CollectionSelectEvent extends CreateCollectionEvent {
  final int id;

  const CollectionSelectEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CollectionSubmitEvent extends CreateCollectionEvent {
  final String title;

  const CollectionSubmitEvent(this.title);

  @override
  List<Object> get props => [title];
}
