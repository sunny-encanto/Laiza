part of 'influencer_form_bloc.dart';

sealed class InfluencerFormState extends Equatable {
  const InfluencerFormState();

  @override
  List<Object> get props => [];
}

final class InfluencerFormInitial extends InfluencerFormState {}

final class InfluencerFormLoadingState extends InfluencerFormState {}

final class InfluencerFormSuccessState extends InfluencerFormState {
  final String message;

  const InfluencerFormSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

final class InfluencerFormErrorState extends InfluencerFormState {
  final String message;

  const InfluencerFormErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class DataFetchedState extends InfluencerFormState {
  final UserModel userModel;

  const DataFetchedState(this.userModel);

  @override
  List<Object> get props => [userModel];
}
