part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

final class FaqInitial extends FaqState {}

final class FaqLoading extends FaqState {}

final class FaqLoaded extends FaqState {
  final List faqs;

  const FaqLoaded(this.faqs);

  @override
  List<Object> get props => [faqs];
}

final class FaqError extends FaqState {
  final String message;

  const FaqError(this.message);

  @override
  List<Object> get props => [message];
}
