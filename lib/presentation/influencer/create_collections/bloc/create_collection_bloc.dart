import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/post_model/post_model.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/collection_repository/collection_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

part 'create_collection_event.dart';
part 'create_collection_state.dart';

class CreateCollectionBloc
    extends Bloc<CreateCollectionEvent, CreateCollectionState> {
  final CollectionRepository _collectionRepository;
  List<Post> _postList = <Post>[];

  CreateCollectionBloc(this._collectionRepository)
      : super(CreateCollectionInitial()) {
    on<CollectionFetchEvent>(_onCollectionFetch);
    on<CollectionSelectEvent>(_onCollectionSelect);
    on<CollectionSubmitEvent>(_onSubmitRequest);
  }

  FutureOr<void> _onCollectionFetch(
      CollectionFetchEvent event, Emitter<CreateCollectionState> emit) async {
    emit(CreateCollectionLoading());
    List<Reel> reels = await ReelRepository().getMyReels();
    for (Reel reel in reels) {
      _postList.add(Post(id: reel.id, url: reel.reelCoverPath, isVideo: true));
    }
    emit(CreateCollectionLoaded(_postList));
  }

  FutureOr<void> _onCollectionSelect(
      CollectionSelectEvent event, Emitter<CreateCollectionState> emit) {
    _postList = _postList.map((item) {
      if (item.id == event.id) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();
    emit(CreateCollectionLoaded(_postList));
  }

  FutureOr<void> _onSubmitRequest(
      CollectionSubmitEvent event, Emitter<CreateCollectionState> emit) async {
    try {
      emit(CreateCollectionRequestLoading());
      List<Post> selectedItems =
          _postList.where((item) => item.isSelected).toList();
      List<String> selectedItemsIds = <String>[];
      for (var item in selectedItems) {
        selectedItemsIds.add(item.id.toString());
      }
      CommonModel model = await _collectionRepository.addCollection(
          title: event.title, reelIds: selectedItemsIds);
      emit(CreateCollectionSuccess(model.message ?? ""));
    } catch (e) {
      emit(CreateCollectionRequestError(e.toString()));
    }
  }
}
