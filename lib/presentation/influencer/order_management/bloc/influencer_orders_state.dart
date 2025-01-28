part of 'influencer_orders_bloc.dart';

sealed class InfluencerOrdersState extends Equatable {
  const InfluencerOrdersState();

  @override
  List<Object> get props => [];
}

final class InfluencerOrdersInitial extends InfluencerOrdersState {}

final class InfluencerOrdersLoading extends InfluencerOrdersState {}

final class InfluencerOrdersLoaded extends InfluencerOrdersState {
  final List orders;

  const InfluencerOrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class InfluencerOrdersError extends InfluencerOrdersState {
  final String message;

  const InfluencerOrdersError(this.message);

  @override
  List<Object> get props => [message];
}
