import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seller_form_event.dart';
part 'seller_form_state.dart';

class SellerFormBloc extends Bloc<SellerFormEvent, SellerFormState> {
  SellerFormBloc() : super(SellerFormInitial()) {
    on<SellerFormSubmitEvent>(onSellerFormSubmit);
  }

  FutureOr<void> onSellerFormSubmit(event, emit) async {
    emit(SellerFormLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SellerFormSuccessState());
  }
}
