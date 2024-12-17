part of 'state_bloc.dart';

sealed class StateEvent extends Equatable {
  const StateEvent();

  @override
  List<Object?> get props => [];
}

class StateLoadEvent extends StateEvent {
  final int countyId;

  const StateLoadEvent(this.countyId);

  @override
  List<Object?> get props => [countyId];
}
