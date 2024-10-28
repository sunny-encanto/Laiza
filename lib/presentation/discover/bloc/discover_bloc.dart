import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverChipSelectEvent>(_onDiscoverChipSelect);
  }

  FutureOr<void> _onDiscoverChipSelect(event, emit) {
    emit(DiscoverChipSelectState(event.selectedIndex));
  }
}
