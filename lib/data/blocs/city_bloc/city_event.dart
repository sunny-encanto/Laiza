part of 'city_bloc.dart';

sealed class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object?> get props => [];
}

class CityLoadEvent extends CityEvent {
  final int stateId;

  const CityLoadEvent(this.stateId);

  @override
  List<Object?> get props => [stateId];
}
