import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/user/user_model.dart';

part 'all_seller_event.dart';
part 'all_seller_state.dart';

class AllSellerBloc extends Bloc<AllSellerEvent, AllSellerState> {
  final UserRepository _userRepository;

  AllSellerBloc(this._userRepository) : super(AllSellerInitial()) {
    on<FetchAllSellerEvent>(_onFetchAllSeller);
  }

  FutureOr<void> _onFetchAllSeller(
      FetchAllSellerEvent event, Emitter<AllSellerState> emit) async {
    try {
      emit(AllSellerLoading());
      List<UserModel> sellers = await _userRepository.getAllSeller();
      emit(AllSellerLoaded(sellers));
    } catch (e) {
      emit(AllSellerError(e.toString()));
    }
  }
}
