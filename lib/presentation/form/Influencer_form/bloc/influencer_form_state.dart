part of 'influencer_form_bloc.dart';

sealed class InfluencerFormState extends Equatable {
  const InfluencerFormState();

  @override
  List<Object> get props => [];
}

final class InfluencerFormInitial extends InfluencerFormState {}

final class SInfluencerFormInitial extends InfluencerFormState {}

final class InfluencerFormLoadingState extends InfluencerFormState {}

final class InfluencerFormSuccessState extends InfluencerFormState {}

final class InfluencerFormErrorState extends InfluencerFormState {}
