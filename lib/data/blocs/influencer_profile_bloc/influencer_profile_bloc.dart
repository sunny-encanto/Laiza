import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/influencer_profile_model/influencer_profile_model.dart';

part 'influencer_profile_event.dart';
part 'influencer_profile_state.dart';

class InfluencerProfileBloc
    extends Bloc<InfluencerProfileEvent, InfluencerProfileState> {
  final UserRepository _userRepository;

  InfluencerProfileBloc(this._userRepository)
      : super(InfluencerProfileInitial()) {
    on<FetchInfluencerProfileEvent>(_onFetchInfluencerProfile);
  }

  FutureOr<void> _onFetchInfluencerProfile(FetchInfluencerProfileEvent event,
      Emitter<InfluencerProfileState> emit) async {
    try {
      emit(InfluencerProfileLoading());
      InfluencerProfileModel influencerProfileModel =
          await _userRepository.getInfluencerProfile(event.id);
      emit(InfluencerProfileLoaded(influencerProfileModel));
    } catch (e) {
      emit(InfluencerProfileError(e.toString()));
    }
  }
}
