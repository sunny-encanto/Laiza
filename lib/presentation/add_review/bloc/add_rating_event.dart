part of 'add_rating_bloc.dart';

sealed class AddRatingEvent extends Equatable {
  const AddRatingEvent();

  @override
  List<Object?> get props => [];
}

class AddRatingRequestEvent extends AddRatingEvent {
  final int productId;
  final int rating;
  final String review;

  const AddRatingRequestEvent(
      {required this.productId, required this.rating, required this.review});

  @override
  List<Object?> get props => [productId, rating, review];
}
