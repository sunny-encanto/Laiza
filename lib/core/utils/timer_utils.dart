import 'dart:async';

import 'package:get/get.dart';

class TimerUtils extends GetxController {
  var timerValue = '00:03'.obs;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (int.parse(timerValue.value.substring(3)) > 0) {
        int secondsRemaining = int.parse(timerValue.value.substring(3)) - 1;
        timerValue.value = timerValue.value.substring(0, 3) +
            secondsRemaining.toString().padLeft(2, '0');
      } else {
        _timer.cancel();
      }
    });
  }

  void stopTimer() {
    timerValue.value = '00:03';
    _timer.cancel();
  }
}
