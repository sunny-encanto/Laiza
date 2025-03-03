part of 'my_order_bloc.dart';

sealed class MyOrderEvent extends Equatable {
  const MyOrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchMyOrders extends MyOrderEvent {}
