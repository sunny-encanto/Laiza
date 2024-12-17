import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:laiza/data/repositories/region_repository/region_repository.dart';

import '../../models/countries/country.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final RegionRepository _regionRepository;

  CountryBloc(this._regionRepository) : super(CountryInitial()) {
    on<CountryLoadEvent>(
        (CountryLoadEvent event, Emitter<CountryState> emit) async {
      try {
        emit(CountryLoadingState());
        List<Country> countries = await _regionRepository.getCountries();
        emit(CountryLoadedSate(countries));
      } catch (e) {
        debugPrint('Country Error $e');
        emit(CountryErrorState(e.toString()));
      }
    });
  }
}
