import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_influencers_event.dart';
part 'favorite_influencers_state.dart';

class FavoriteInfluencersBloc
    extends Bloc<FavoriteInfluencersEvent, FavoriteInfluencersState> {
  FavoriteInfluencersBloc() : super(FavoriteInfluencersInitial()) {
    on<FetchFavInfluencersEvent>(_onFetchFavInfluencers);
  }

  FutureOr<void> _onFetchFavInfluencers(FetchFavInfluencersEvent event,
      Emitter<FavoriteInfluencersState> emit) async {
    try {
      emit(FavoriteInfluencersLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(const FavoriteInfluencersLoaded([]));
    } catch (e) {
      emit(FavoriteInfluencersError(e.toString()));
    }
  }
}
