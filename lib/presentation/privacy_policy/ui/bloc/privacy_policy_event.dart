part of 'privacy_policy_bloc.dart';

sealed class PrivacyPolicyEvent extends Equatable {
  const PrivacyPolicyEvent();

  @override
  List<Object?> get props => [];
}

class FetchPrivacyPolicyEvent extends PrivacyPolicyEvent {}

class FetchTermsAndConditionsEvent extends PrivacyPolicyEvent {}

class FetchResponsibleDisclosurePolicyEvent extends PrivacyPolicyEvent {}

class FetchAntiPhishingPolicyEvent extends PrivacyPolicyEvent {}

class IntellectualPropertyPolicyEvent extends PrivacyPolicyEvent {}

class RefundReturnReplacementPolicyEvent extends PrivacyPolicyEvent {}

class LaizaCancellationRefundPolicyEvent extends PrivacyPolicyEvent {}

class ThirdPartyFunctionalitiesEvent extends PrivacyPolicyEvent {}
