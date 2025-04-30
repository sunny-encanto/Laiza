import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';

import '../../../../data/models/seller_details_model/seller_details_model.dart';
import '../../../../data/repositories/connections_repository/connections_repository.dart';

part 'seller_info_event.dart';
part 'seller_info_state.dart';

class SellerInfoBloc extends Bloc<SellerInfoEvent, SellerInfoState> {
  final UserRepository _userRepository;

  SellerInfoBloc(this._userRepository) : super(SellerInfoInitial()) {
    on<FetchSellerInfo>((event, emit) async {
      try {
        emit(SellerInfoLoading());
        SellerDetailsData sellerDetailsData =
            await _userRepository.getSellerProfile(event.id);
        emit(SellerInfoLoaded(sellerDetailsData));
      } catch (e) {
        emit(SellerInfoError(e.toString()));
      }
    });

    on<SellerInfoAddConnectionEvent>((event, emit) async {
      try {
        // emit(SellerInfoLoading());
        await ConnectionsRepository().sendConnection(event.id);
        emit(SellerInfoAddConnection(event.isConnected));
      } catch (e) {
        emit(SellerInfoAddConnectionError(e.toString()));
      }
    });
  }
}
