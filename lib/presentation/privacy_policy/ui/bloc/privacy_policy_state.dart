part of 'privacy_policy_bloc.dart';

sealed class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();

  @override
  List<Object> get props => [];
}

final class PrivacyPolicyInitial extends PrivacyPolicyState {}

final class PrivacyPolicyLading extends PrivacyPolicyState {}

final class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final String privacyPolicy;

  const PrivacyPolicyLoaded(this.privacyPolicy);

  @override
  List<Object> get props => [privacyPolicy];
}

final class PrivacyPolicyError extends PrivacyPolicyState {
  final String message;

  const PrivacyPolicyError(this.message);

  @override
  List<Object> get props => [message];
}
