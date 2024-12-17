import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/city_model/city.dart';
import 'package:laiza/data/repositories/region_repository/region_repository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final RegionRepository _regionRepository;

  CityBloc(this._regionRepository) : super(CityInitial()) {
    on<CityLoadEvent>((event, emit) async {
      emit(CityLoadingSate());
      List<City> cities = await _regionRepository.getCities(event.stateId);
      emit(CityLoaded(cities));
    });
  }
}
