import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/advertisement_repository/advertisement_repository.dart';

import '../../models/advertisement_model/advertisement_model.dart';

part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  final AdvertisementRepository _advertisementRepository;

  AdvertisementBloc(this._advertisementRepository)
      : super(AdvertisementInitial()) {
    on<AdvertisementEvent>(_onFetchAdvertisement);
  }

  FutureOr<void> _onFetchAdvertisement(
      AdvertisementEvent event, Emitter<AdvertisementState> emit) async {
    try {
      emit(AdvertisementLoading());
      List<Advertisement> advertisement =
          await _advertisementRepository.getAdvertisement();
      emit(AdvertisementLoaded(advertisement));
    } catch (e) {
      emit(AdvertisementError(e.toString()));
    }
  }
}
