import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_summary_event.dart';
part 'order_summary_state.dart';

class OrderSummaryBloc extends Bloc<OrderSummaryEvent, OrderSummaryState> {
  OrderSummaryBloc() : super(OrderSummaryInitial()) {
    on<OrderSummaryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
