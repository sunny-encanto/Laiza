import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'influencer_my_profile_event.dart';
part 'influencer_my_profile_state.dart';

class InfluencerMyProfileBloc
    extends Bloc<InfluencerMyProfileEvent, InfluencerMyProfileState> {
  InfluencerMyProfileBloc() : super(InfluencerMyProfileInitial()) {
    on<InfluencerMyProfileEvent>((event, emit) {});
  }
}
