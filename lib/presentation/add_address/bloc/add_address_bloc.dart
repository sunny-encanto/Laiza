import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/address_model/address_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../data/repositories/address_repository/address_repository.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRepository _addressRepository;

  AddAddressBloc(this._addressRepository) : super(AddAddressInitial()) {
    on<DefaultAddressToggleEvent>(onToggleDefault);
    on<AddAddressSubmitEvent>(onSubmitAddress);
  }

  FutureOr<void> onToggleDefault(
      DefaultAddressToggleEvent event, Emitter<AddAddressState> emit) {
    emit(DefaultAddressToggleState(event.isDefault));
  }

  FutureOr<void> onSubmitAddress(
      AddAddressSubmitEvent event, Emitter<AddAddressState> emit) async {
    try {
      emit(AddAddressLoadingState());
      CommonModel model = await _addressRepository.addAddress(event.address);
      emit(AddAddressSuccessState(model.message ?? ''));
    } catch (e) {
      emit(AddAddressErrorState(message: e.toString()));
    }
  }
}
