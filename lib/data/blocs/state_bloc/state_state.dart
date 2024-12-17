part of 'state_bloc.dart';

sealed class StateState extends Equatable {
  const StateState();
}

final class StateInitial extends StateState {
  @override
  List<Object> get props => [];
}

final class StateLoading extends StateState {
  @override
  List<Object> get props => [];
}

final class StateLoaded extends StateState {
  final List<State> states;

  const StateLoaded(this.states);

  @override
  List<Object> get props => [states];
}
