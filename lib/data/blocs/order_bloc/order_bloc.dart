import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/order_repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderInitial()) {
    on<CreateOrderEvent>(_onCreateOrder);
  }

  FutureOr<void> _onCreateOrder(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    try {
      emit(CreateOrderLoading());
      //Need to Change Here
      CommonModel model = await _orderRepository.crateOrder([]);
      emit(OrderCreated(model.message ?? ''));
    } catch (e) {
      emit(CreateOrderErrorState(e.toString()));
    }
  }
}
