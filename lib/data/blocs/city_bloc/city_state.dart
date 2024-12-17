part of 'city_bloc.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoadingSate extends CityState {}

final class CityLoaded extends CityState {
  final List<City> cities;

  const CityLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}
