part of 'advertisement_bloc.dart';

sealed class AdvertisementState extends Equatable {
  const AdvertisementState();

  @override
  List<Object> get props => [];
}

final class AdvertisementInitial extends AdvertisementState {}

final class AdvertisementLoading extends AdvertisementState {}

final class AdvertisementLoaded extends AdvertisementState {
  final List<Advertisement> advertisement;

  const AdvertisementLoaded(this.advertisement);

  @override
  List<Object> get props => [advertisement];
}

final class AdvertisementError extends AdvertisementState {
  final String message;

  const AdvertisementError(this.message);

  @override
  List<Object> get props => [message];
}
