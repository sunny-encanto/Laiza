import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../../models/reels_model/reel.dart';

part 'reel_from_followed_influencer_event.dart';
part 'reel_from_followed_influencer_state.dart';

class ReelFromFollowedInfluencerBloc extends Bloc<
    ReelFromFollowedInfluencerEvent, ReelFromFollowedInfluencerState> {
  final ReelRepository _reelRepository;

  ReelFromFollowedInfluencerBloc(this._reelRepository)
      : super(ReelFromFollowedInfluencerInitial()) {
    on<FetchReelFromFollowedInfluencer>(_onFetchReelFromFollowedInfluencer);
  }

  FutureOr<void> _onFetchReelFromFollowedInfluencer(
      FetchReelFromFollowedInfluencer event,
      Emitter<ReelFromFollowedInfluencerState> emit) async {
    try {
      emit(ReelFromFollowedInfluencerLoading());
      List<Reel> reel =
          await _reelRepository.getAllReelsFromFollowedInfluencer();
      emit(ReelFromFollowedInfluencerLoaded(reel));
    } catch (e) {
      emit(ReelFromFollowedInfluencerError(e.toString()));
    }
  }
}
