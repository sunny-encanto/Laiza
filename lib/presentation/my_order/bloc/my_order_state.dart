part of 'my_order_bloc.dart';

sealed class MyOrderState extends Equatable {
  const MyOrderState();

  @override
  List<Object> get props => [];
}

final class MyOrderInitial extends MyOrderState {}

final class MyOrderLoading extends MyOrderState {}

final class MyOrderError extends MyOrderState {
  final String message;

  const MyOrderError(this.message);

  @override
  List<Object> get props => [message];
}

final class MyOrderLoaded extends MyOrderState {
  final MyOrdersModel myOrdersModel;

  const MyOrderLoaded(this.myOrdersModel);

  @override
  List<Object> get props => [myOrdersModel];
}
