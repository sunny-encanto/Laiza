part of 'add_rating_bloc.dart';

sealed class AddRatingState extends Equatable {
  const AddRatingState();

  @override
  List<Object> get props => [];
}

final class AddRatingInitial extends AddRatingState {}

final class AddRatingLoading extends AddRatingState {}

final class AddRatingSuccess extends AddRatingState {
  final String message;

  const AddRatingSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class AddRatingError extends AddRatingState {
  final String message;

  const AddRatingError(this.message);

  @override
  List<Object> get props => [message];
}
