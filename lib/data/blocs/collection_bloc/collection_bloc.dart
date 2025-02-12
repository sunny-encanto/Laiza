import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/collection_repository/collection_repository.dart';

import '../../models/influencer_profile_model/influencer_profile_model.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionRepository _collectionRepository;

  CollectionBloc(this._collectionRepository) : super(CollectionInitial()) {
    on<FetchCollection>(_onFetchCollection);
    on<FetchCollectionDetails>(_onFetchCollectionDetails);
    on<DeleteCollection>(_onDeleteCollection);
  }

  FutureOr<void> _onFetchCollection(
      FetchCollection event, Emitter<CollectionState> emit) async {
    try {
      emit(CollectionLoading());
      List<Collection> collection = await _collectionRepository.getCollection();
      emit(CollectionLoaded(collection));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  FutureOr<void> _onFetchCollectionDetails(
      FetchCollectionDetails event, Emitter<CollectionState> emit) async {
    try {
      emit(CollectionLoading());
      List<Collection> collection =
          await _collectionRepository.getCollectionDetails(event.id);
      emit(CollectionLoaded(collection));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  FutureOr<void> _onDeleteCollection(
      DeleteCollection event, Emitter<CollectionState> emit) async {
    try {
      emit(CollectionLoading());
      CommonModel model =
          await _collectionRepository.deleteCollection(event.id);
      emit(CollectionDeleteSuccess(model.message ?? ''));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }
}
