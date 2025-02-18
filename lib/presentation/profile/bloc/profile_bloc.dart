import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/user/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc(this._userRepository) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final UserModel userModel = await _userRepository.getUserProfile();
        emit(ProfileLoaded(userModel));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
