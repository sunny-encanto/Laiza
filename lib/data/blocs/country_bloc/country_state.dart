part of 'country_bloc.dart';

sealed class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

final class CountryInitial extends CountryState {}

final class CountryLoadingState extends CountryState {}

final class CountryLoadedSate extends CountryState {
  final List<Country> countries;

  const CountryLoadedSate(this.countries);

  @override
  List<Object> get props => [countries];
}

final class CountryErrorState extends CountryState {
  final String message;

  const CountryErrorState(this.message);

  @override
  List<Object> get props => [message];
}
