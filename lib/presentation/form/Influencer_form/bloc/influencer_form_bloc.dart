import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'influencer_form_event.dart';
part 'influencer_form_state.dart';

class InfluencerFormBloc
    extends Bloc<InfluencerFormEvent, InfluencerFormState> {
  InfluencerFormBloc() : super(InfluencerFormInitial()) {
    on<InfluencerFormSubmitEvent>(onInfluencerFormSubmit);
  }
  FutureOr<void> onInfluencerFormSubmit(event, emit) async {
    emit(InfluencerFormLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(InfluencerFormSuccessState());
  }
}
