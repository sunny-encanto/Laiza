part of 'order_summary_bloc.dart';

sealed class OrderSummaryState extends Equatable {
  const OrderSummaryState();

  @override
  List<Object> get props => [];
}

final class OrderSummaryInitial extends OrderSummaryState {}

final class ApplyCouponCodeLoading extends OrderSummaryState {}

final class ApplyCouponCodeLoaded extends OrderSummaryState {}

final class ApplyCouponCodeError extends OrderSummaryState {
  final String message;

  const ApplyCouponCodeError(this.message);

  @override
  List<Object> get props => [message];
}
