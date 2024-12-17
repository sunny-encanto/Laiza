import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/states_model/state.dart';
import 'package:laiza/data/repositories/region_repository/region_repository.dart';

part 'state_event.dart';
part 'state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  final RegionRepository _regionRepository;

  StateBloc(this._regionRepository) : super(StateInitial()) {
    on<StateLoadEvent>((event, emit) async {
      emit(StateLoading());
      List<State> states = await _regionRepository.getStates(event.countyId);
      emit(StateLoaded(states));
    });
  }
}
