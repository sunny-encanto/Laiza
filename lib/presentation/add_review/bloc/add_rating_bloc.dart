import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/rating_repository/rating_repository.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final RatingRepository _ratingRepository;

  AddRatingBloc(this._ratingRepository) : super(AddRatingInitial()) {
    on<AddRatingRequestEvent>(_onAddRatingRequestEvent);
  }

  FutureOr<void> _onAddRatingRequestEvent(
      AddRatingRequestEvent event, Emitter<AddRatingState> emit) async {
    try {
      emit(AddRatingLoading());
      CommonModel model = await _ratingRepository.addRating(
          productId: event.productId,
          rating: event.rating,
          review: event.review);
      emit(AddRatingSuccess(model.message ?? ''));
    } catch (e) {
      emit(AddRatingError(e.toString()));
    }
  }
}
