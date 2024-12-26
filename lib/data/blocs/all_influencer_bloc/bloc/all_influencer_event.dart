part of 'all_influencer_bloc.dart';

sealed class AllInfluencerEvent extends Equatable {
  const AllInfluencerEvent();

  @override
  List<Object> get props => [];
}

class FetchAllInfluencer extends AllInfluencerEvent {}

class MakeFollowRequestEvent extends AllInfluencerEvent {
  final String id;

  const MakeFollowRequestEvent(this.id);

  @override
  List<Object> get props => [id];
}
