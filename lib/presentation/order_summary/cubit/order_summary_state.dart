part of 'order_summary_cubit.dart';

sealed class OrderSummaryState extends Equatable {
  const OrderSummaryState();

  @override
  List<Object> get props => [];
}

final class OrderSummaryInitial extends OrderSummaryState {}

final class DiscountAdded extends OrderSummaryState {
  final num discountPrice;
  final num totalPrice;

  const DiscountAdded({required this.discountPrice, required this.totalPrice});

  @override
  List<Object> get props => [discountPrice, totalPrice];
}
