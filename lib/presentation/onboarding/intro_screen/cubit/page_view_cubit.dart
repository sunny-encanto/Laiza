import 'dart:async';

import 'package:bloc/bloc.dart';

class PageViewCubit extends Cubit<int> {
  Timer? _timer;
  final int itemCount;

  PageViewCubit({required this.itemCount}) : super(0) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int newIndex = (state + 1) % itemCount;
      emit(newIndex);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
