import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(AddAddressInitial()) {
    on<DefaultAddressToggleEvent>(onToggleDefault);
    on<AddAddressSubmitEvent>(onSubmitAddress);
  }

  FutureOr<void> onToggleDefault(
      DefaultAddressToggleEvent event, Emitter<AddAddressState> emit) {
    emit(DefaultAddressToggleState(event.isDefault));
  }

  FutureOr<void> onSubmitAddress(
      AddAddressSubmitEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState()); // Emit loading state

    try {
      // Simulate adding the address (e.g., to a database)
      await Future.delayed(const Duration(seconds: 2));
      // Emit success state after adding the address
      emit(AddAddressSuccessState());
    } catch (e) {
      emit(AddAddressErrorState(message: e.toString()));
    }
  }
}
