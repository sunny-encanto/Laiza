import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../../models/common_model/common_model.dart';
import '../../models/reels_model/reel.dart';

part 'my_reel_event.dart';
part 'my_reel_state.dart';

class MyReelBloc extends Bloc<MyReelEvent, MyReelState> {
  final ReelRepository _reelRepository;
  List<Reel> reels = <Reel>[];

  MyReelBloc(this._reelRepository) : super(MyReelInitial()) {
    on<LoadMyReelEvent>(_onLoadReels);
    on<ToggleMyReelLikeButtonEvent>(_onToggleLikeButton);
    on<MyReelDeleteEvent>(_onMyReelDelete);
  }

  Future<void> _onLoadReels(
      LoadMyReelEvent event, Emitter<MyReelState> emit) async {
    emit(MyReelLoading());
    try {
      reels = await _reelRepository.getMyReels();
      emit(MyReelLoaded(reels));
    } catch (e) {
      emit(MyReelError(e.toString()));
    }
  }

  FutureOr<void> _onToggleLikeButton(
      ToggleMyReelLikeButtonEvent event, Emitter<MyReelState> emit) {
    reels = reels.map((item) {
      if (item.id == event.id) {
        if (item.likeStatus == 0) {
          _reelRepository.addReelLike(event.id);
          return item.copyWith(likeStatus: 1, likesCount: item.likesCount + 1);
        } else {
          _reelRepository.removeReelLike(event.id);
          return item.copyWith(likeStatus: 0, likesCount: item.likesCount - 1);
        }
      }
      return item;
    }).toList();
    emit(MyReelLoaded(reels));
  }

  FutureOr<void> _onMyReelDelete(
      MyReelDeleteEvent event, Emitter<MyReelState> emit) async {
    try {
      CommonModel model = await _reelRepository.deleteReel(event.id);
      emit(MyReelDeleteSuccess(model.message ?? ''));
    } catch (e) {
      emit(MyReelDeleteError(e.toString()));
    }
  }
}
