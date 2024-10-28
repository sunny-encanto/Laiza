part of 'influencer_form_bloc.dart';

sealed class InfluencerFormEvent extends Equatable {
  const InfluencerFormEvent();

  @override
  List<Object> get props => [];
}

final class InfluencerFormSubmitEvent extends InfluencerFormEvent {}
