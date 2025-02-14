import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';

import '../../../models/user/user_model.dart';
import '../../../repositories/user_repository/user_repository.dart';

part 'all_influencer_event.dart';
part 'all_influencer_state.dart';

class AllInfluencerBloc extends Bloc<AllInfluencerEvent, AllInfluencerState> {
  final UserRepository _userRepository;
  final FollowersRepository _followersRepository;
  List<UserModel> influencers = <UserModel>[];

  AllInfluencerBloc(this._userRepository, this._followersRepository)
      : super(AllInfluencerInitial()) {
    on<FetchAllInfluencer>(_onFetchAllInfluencer);
    on<MakeFollowRequestEvent>(_onFollowRequest);
  }

  FutureOr<void> _onFetchAllInfluencer(event, emit) async {
    try {
      emit(AllInfluencerLoading());
      influencers = await _userRepository.getAllInfluencer();
      emit(AllInfluencerLoaded(influencers));
    } catch (e) {
      emit(const AllInfluencerError('Something went wrong'));
    }
  }

  FutureOr<void> _onFollowRequest(
      MakeFollowRequestEvent event, Emitter<AllInfluencerState> emit) async {
    influencers = influencers.map((UserModel item) {
      if (item.id == event.id) {
        if ((item.isFollowed ?? false)) {
          _followersRepository.unFollow(event.id);
        } else {
          _followersRepository.follow(event.id);
        }
        return item.copyWith(
            isFollowed: (item.isFollowed ?? false) ? false : true);
      }
      return item;
    }).toList();
    emit(AllInfluencerLoaded(influencers));
  }
}
