import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/order_repository/order_repository.dart';

import '../../../data/models/my_orders_model/my_order_model.dart';

part 'my_order_event.dart';
part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  final OrderRepository _orderRepository;

  MyOrderBloc(this._orderRepository) : super(MyOrderInitial()) {
    on<FetchMyOrders>(_onFetchMyOrders);
  }

  FutureOr<void> _onFetchMyOrders(
      FetchMyOrders event, Emitter<MyOrderState> emit) async {
    try {
      emit(MyOrderLoading());
      MyOrdersModel myOrdersModel = await _orderRepository.getMyOrders();
      emit(MyOrderLoaded(myOrdersModel));
    } catch (e) {
      emit(MyOrderError(e.toString()));
    }
  }
}
