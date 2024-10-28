import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/connections_model/connections_model.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsLoadEvent>(_onChatsLoad);
    on<ChatsSearchEvent>(_onChatsSearch);
  }

  FutureOr<void> _onChatsLoad(
      ChatsLoadEvent event, Emitter<ChatsState> emit) async {
    emit(ChatsLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(ChatsLoadedSate(connectionsList));
  }

  FutureOr<void> _onChatsSearch(
      ChatsSearchEvent event, Emitter<ChatsState> emit) {
    final updatedList = connectionsList
        .where((item) => item.name.toLowerCase().contains(event.query))
        .toList();
    emit(ChatsLoadedSate(updatedList));
  }
}
