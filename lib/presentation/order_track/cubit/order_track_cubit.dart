import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/order_repository/order_repository.dart';

import '../../../data/models/singleOrderDetails/singleorderDetials.dart';
import '../../../data/models/tracking_model/tracking_model.dart';

part 'order_track_state.dart';

class OrderTrackCubit extends Cubit<OrderTrackState> {
  final OrderRepository _orderRepository;

  OrderTrackCubit(this._orderRepository) : super(OrderTrackInitial());

  void onFetchTrackingDetails(String trackingId) async {
    try {
      emit(OrderTrackLoading());
      TrackingDetailModel trackingDetailModel =
          await _orderRepository.trackOrder(trackingId);
      emit(OrderTrackLoaded(trackingDetailModel));
    } catch (e) {
      emit(OrderTrackError(e.toString()));
    }
  }

  void onFetchOrderDetails(String id) async {
    try {
      SingleOrderDetailsModel trackingDetailModel =
          await _orderRepository.singleOrderDetails(id);
      emit(SingleOrderDetailsLoaded(trackingDetailModel));
    } catch (e) {
      emit(SingleOrderDetailError(e.toString()));
    }
  }
}
