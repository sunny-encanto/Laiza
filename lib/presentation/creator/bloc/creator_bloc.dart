import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'creator_event.dart';
part 'creator_state.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  CreatorBloc() : super(CreatorInitial()) {
    on<CreatorsCategoryChipSelectedEvent>(onCategorySelect);
  }

  FutureOr<void> onCategorySelect(
      CreatorsCategoryChipSelectedEvent event, Emitter<CreatorState> emit) {
    emit(CreatorsCategoryChipSelectedState(event.categoryId));
  }
}
