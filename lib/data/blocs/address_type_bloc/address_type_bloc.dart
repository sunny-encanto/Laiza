import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/address_model/address_type_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';

part 'address_type_event.dart';
part 'address_type_state.dart';

class AddressTypeBloc extends Bloc<AddressTypeEvent, AddressTypeState> {
  final AddressRepository _addressRepository;

  AddressTypeBloc(this._addressRepository) : super(AddressTypeInitial()) {
    on<FetchAddressTypeEvent>(_onFetchAddressType);
  }

  FutureOr<void> _onFetchAddressType(
      FetchAddressTypeEvent event, Emitter<AddressTypeState> emit) async {
    try {
      emit(AddressTypeLoading());
      List<AddressType> addressType = await _addressRepository.getAddressType();
      emit(AddressTypeLoaded(addressType));
    } catch (e) {
      emit(AddressTypeError(e.toString()));
    }
  }
}
