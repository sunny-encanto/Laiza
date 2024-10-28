import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';

part 'create_collection_event.dart';
part 'create_collection_state.dart';

class CreateCollectionBloc
    extends Bloc<CreateCollectionEvent, CreateCollectionState> {
  CreateCollectionBloc() : super(CreateCollectionInitial()) {
    on<CollectionFetchEvent>(_onCollectionFetch);
    on<CollectionSelectEvent>(_onCollectionSelect);
  }

  FutureOr<void> _onCollectionFetch(
      CollectionFetchEvent event, Emitter<CreateCollectionState> emit) async {
    emit(CreateCollectionLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(CreateCollectionLoaded(postList));
  }

  FutureOr<void> _onCollectionSelect(
      CollectionSelectEvent event, Emitter<CreateCollectionState> emit) {
    postList = postList.map((item) {
      if (item.id == event.id) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();
    emit(CreateCollectionLoaded(postList));
  }
}
