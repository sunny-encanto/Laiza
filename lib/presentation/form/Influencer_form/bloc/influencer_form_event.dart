part of 'influencer_form_bloc.dart';

sealed class InfluencerFormEvent extends Equatable {
  const InfluencerFormEvent();

  @override
  List<Object> get props => [];
}

final class InfluencerFormSubmitEvent extends InfluencerFormEvent {
  final UserModel userModel;

  const InfluencerFormSubmitEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}
