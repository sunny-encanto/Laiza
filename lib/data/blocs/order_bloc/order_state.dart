part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class CreateOrderErrorState extends OrderState {
  final String message;

  const CreateOrderErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class OrderCreated extends OrderState {
  final String message;

  const OrderCreated(this.message);

  @override
  List<Object> get props => [message];
}

final class CreateOrderLoading extends OrderState {}
