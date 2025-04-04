part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final PaymentMode paymentMode;

  const CreateOrderEvent(this.paymentMode);

  @override
  List<Object?> get props => [paymentMode];
}
