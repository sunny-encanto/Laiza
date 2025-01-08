import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

part 'reel_event.dart';
part 'reel_state.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  final ReelRepository _reelRepository;

  ReelBloc(this._reelRepository) : super(ReelInitial()) {
    // Handle loading of reels
    on<LoadReelEvent>(_onLoadReels);

    on<ReelFollowRequestEvent>(_onFollowRequest);
  }

  Future<void> _onLoadReels(
      LoadReelEvent event, Emitter<ReelState> emit) async {
    emit(ReelLoading());
    try {
      List<Reel> reels = await _reelRepository.getReels();
      emit(ReelLoaded(reels));
    } catch (e) {
      emit(ReelError(e.toString()));
    }
  }

  FutureOr<void> _onFollowRequest(
      ReelFollowRequestEvent event, Emitter<ReelState> emit) async {
    emit(ReelFollowRequestState(event.isFollowed));
  }
}
