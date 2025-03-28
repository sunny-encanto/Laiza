part of 'earning_cubit.dart';

sealed class EarningState extends Equatable {
  const EarningState();

  @override
  List<Object> get props => [];
}

final class EarningInitial extends EarningState {}

final class EarningLoading extends EarningState {}

final class EarningError extends EarningState {
  final String message;

  const EarningError(this.message);

  @override
  List<Object> get props => [message];
}

final class EarningLoaded extends EarningState {
  final InfluencerOrderModel influencerOrder;

  const EarningLoaded(this.influencerOrder);

  @override
  List<Object> get props => [influencerOrder];
}
