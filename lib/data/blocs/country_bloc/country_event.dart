part of 'country_bloc.dart';

sealed class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object?> get props => [];
}

class CountryLoadEvent extends CountryEvent {}
