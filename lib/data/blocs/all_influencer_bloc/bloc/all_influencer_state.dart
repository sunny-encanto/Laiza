part of 'all_influencer_bloc.dart';

sealed class AllInfluencerState extends Equatable {
  const AllInfluencerState();

  @override
  List<Object> get props => [];
}

final class AllInfluencerInitial extends AllInfluencerState {}

final class AllInfluencerLoading extends AllInfluencerState {}

final class AllInfluencerLoaded extends AllInfluencerState {
  final List<UserModel> influencers;
  const AllInfluencerLoaded(this.influencers);
  @override
  List<Object> get props => [influencers];
}

final class AllInfluencerError extends AllInfluencerState {
  final String message;
  const AllInfluencerError(this.message);
  @override
  List<Object> get props => [message];
}
