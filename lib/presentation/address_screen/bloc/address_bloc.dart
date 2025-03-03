import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/address_model/address_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository _addressRepository;

  AddressBloc(this._addressRepository) : super(AddressInitial()) {
    on<FetchAddressEvent>(_onFetchAddress);
    on<FetchDefaultAddressEvent>(_onFetchDefaultAddress);
  }

  FutureOr<void> _onFetchAddress(
      FetchAddressEvent event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());
      List<Address> address = await _addressRepository.getAddress();
      emit(AddressLoaded(address));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  FutureOr<void> _onFetchDefaultAddress(
      FetchDefaultAddressEvent event, Emitter<AddressState> emit) async {
    try {
      emit(AddressLoading());
      Address address = await _addressRepository.getDefaultAddress();
      emit(DefaultAddressLoaded(address));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
