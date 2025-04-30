import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/help_center_repository/help_center_repository.dart';

part 'privacy_policy_event.dart';
part 'privacy_policy_state.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  final HelpCenterRepository _helpCenterRepository;

  PrivacyPolicyBloc(this._helpCenterRepository)
      : super(PrivacyPolicyInitial()) {
    on<FetchPrivacyPolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.getPrivacyPolicy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<FetchTermsAndConditionsEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.getTermsAndCondition();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<FetchResponsibleDisclosurePolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.responsibleDisclosurePolicy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });
    on<FetchAntiPhishingPolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.antiPhishingPolicy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<IntellectualPropertyPolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.intellectualPropertyPolicy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<RefundReturnReplacementPolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.refundReturnReplacementPolicy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<LaizaCancellationRefundPolicyEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.laiza_cancellation_refund_policy();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });

    on<ThirdPartyFunctionalitiesEvent>((event, emit) async {
      try {
        emit(PrivacyPolicyLading());
        final String privacyPolicy =
            await _helpCenterRepository.third_party_functionalities();
        emit(PrivacyPolicyLoaded(privacyPolicy));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });
  }
}
