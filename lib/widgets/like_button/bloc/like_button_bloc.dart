import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'like_button_event.dart';
part 'like_button_state.dart';

class LikeButtonBloc extends Bloc<LikeButtonEvent, LikeButtonState> {
  LikeButtonBloc() : super(LikeButtonInitial()) {
    on<LikeButtonPressEvent>((event, emit) {
      emit(LikeButtonPressState(event.isLIked));
    });
  }
}
