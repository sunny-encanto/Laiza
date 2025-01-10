import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

part 'like_button_event.dart';
part 'like_button_state.dart';

class LikeButtonBloc extends Bloc<LikeButtonEvent, LikeButtonState> {
  final ReelRepository _reelRepository;

  LikeButtonBloc(this._reelRepository) : super(LikeButtonInitial()) {
    on<LikeButtonPressEvent>((event, emit) async {
      emit(LikeButtonPressState(event.isLiked));
      if (event.isLiked) {
        _reelRepository.addReelLike(event.reelId);
      } else {
        _reelRepository.removeReelLike(event.reelId);
      }
    });
  }
}
