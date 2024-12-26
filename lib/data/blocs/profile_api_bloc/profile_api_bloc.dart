import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/user_repository/user_repository.dart';

part 'profile_api_event.dart';
part 'profile_api_state.dart';

class ProfileApiBloc extends Bloc<ProfileApiEvent, ProfileApiState> {
  final UserRepository _userRepository;

  ProfileApiBloc(this._userRepository) : super(ProfileApiInitial()) {
    on<FetchProfileApi>((event, emit) async {
      try {
        emit(ProfileApiLoadingState());
        UserModel userModel = await _userRepository.getUserProfile();
        emit(ProfileApiLoadedState(userModel));
      } catch (e) {
        emit(ProfileApiError(e.toString()));
      }
    });
  }
}
