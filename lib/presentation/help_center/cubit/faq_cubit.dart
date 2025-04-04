import 'package:bloc/bloc.dart';

class FaqCubit extends Cubit<int?> {
  FaqCubit() : super(null);

  void expandFAQ(int index) {
    if (state == index) {
      emit(null);
    } else {
      emit(index);
    }
  }
}
