import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(const BottomBarState(0));
  void selectTab(int index) {
    // if (index != 0) {
    //   ReelScreenState().pauseVideo();
    // }
    emit(BottomBarState(index));
  }
}
