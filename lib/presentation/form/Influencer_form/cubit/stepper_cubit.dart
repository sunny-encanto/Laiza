import 'package:bloc/bloc.dart';

class StepperCubit extends Cubit<int> {
  StepperCubit() : super(0);

  void nextStep(int maxSteps) {
    if (state < maxSteps - 1) {
      emit(state + 1);
    }
  }

  void previousStep() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void goToStep(int step) {
    emit(step);
  }
}
