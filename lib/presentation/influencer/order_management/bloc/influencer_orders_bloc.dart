import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'influencer_orders_event.dart';
part 'influencer_orders_state.dart';

class InfluencerOrdersBloc
    extends Bloc<InfluencerOrdersEvent, InfluencerOrdersState> {
  InfluencerOrdersBloc() : super(InfluencerOrdersInitial()) {
    on<FetchInfluencerOrdersEvent>(_onInfluencerOrder);
  }

  FutureOr<void> _onInfluencerOrder(FetchInfluencerOrdersEvent event,
      Emitter<InfluencerOrdersState> emit) async {
    try {
      emit(InfluencerOrdersLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(const InfluencerOrdersLoaded([]));
    } catch (e) {
      emit(InfluencerOrdersError(e.toString()));
    }
  }
}
