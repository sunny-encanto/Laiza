import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/user_repository/user_repository.dart';

part 'influencer_form_event.dart';
part 'influencer_form_state.dart';

class InfluencerFormBloc
    extends Bloc<InfluencerFormEvent, InfluencerFormState> {
  final UserRepository _userRepository;

  InfluencerFormBloc(this._userRepository) : super(InfluencerFormInitial()) {
    on<InfluencerFormSubmitEvent>(onInfluencerFormSubmit);
  }

  FutureOr<void> onInfluencerFormSubmit(
      InfluencerFormSubmitEvent event, emit) async {
    try {
      emit(InfluencerFormLoadingState());
      await _userRepository.updateUserProfile(event.userModel);
      emit(const InfluencerFormSuccessState('Success'));
    } catch (e) {
      emit(InfluencerFormErrorState(e.toString()));
    }
  }
}
