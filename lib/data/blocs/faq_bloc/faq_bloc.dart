import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/help_center_repository/help_center_repository.dart';

import '../../models/faq_model/faq_model.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final HelpCenterRepository _helpCenterRepository;

  FaqBloc(this._helpCenterRepository) : super(FaqInitial()) {
    on<FetchFAQ>(_onFetchFAQ);
  }

  FutureOr<void> _onFetchFAQ(FetchFAQ event, Emitter<FaqState> emit) async {
    try {
      emit(FaqLoading());
      List<FAQ> faqs = await _helpCenterRepository.getFAQ();
      emit(FaqLoaded(faqs));
    } catch (e) {
      emit(FaqError(e.toString()));
    }
  }
}
