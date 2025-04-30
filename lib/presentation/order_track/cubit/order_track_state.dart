part of 'order_track_cubit.dart';

sealed class OrderTrackState extends Equatable {
  const OrderTrackState();

  @override
  List<Object> get props => [];
}

final class OrderTrackInitial extends OrderTrackState {}

final class OrderTrackLoading extends OrderTrackState {}

final class OrderTrackError extends OrderTrackState {
  final String message;

  const OrderTrackError(this.message);

  @override
  List<Object> get props => [message];
}

final class SingleOrderDetailError extends OrderTrackState {
  final String message;

  const SingleOrderDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class OrderTrackLoaded extends OrderTrackState {
  final TrackingDetailModel trackingDetailModel;

  const OrderTrackLoaded(this.trackingDetailModel);

  @override
  List<Object> get props => [trackingDetailModel];
}

final class SingleOrderDetailsLoaded extends OrderTrackState {
  final SingleOrderDetailsModel trackingDetailModel;

  const SingleOrderDetailsLoaded(this.trackingDetailModel);

  @override
  List<Object> get props => [trackingDetailModel];
}
