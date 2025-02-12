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
  }
}
