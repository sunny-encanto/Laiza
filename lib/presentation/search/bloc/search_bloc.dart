import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/search_model/search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<SearchModel> filteredList = <SearchModel>[];
  SearchBloc() : super(SearchInitial()) {
    on<SearchUserInteractionEvent>(_onSearchUserInteraction);
  }

  FutureOr<void> _onSearchUserInteraction(
      SearchUserInteractionEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchResultLoadingState());
      filteredList = searchResult
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      if (event.query.isEmpty) {
        filteredList.clear();
      }
      emit(SearchResultLoadedState(filteredList));
    } catch (e) {
      emit(SearchErrorState('Failed to Search $e'));
    }
  }
}
