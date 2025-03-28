import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/influencer_order_model/influencer_order_model.dart';
import 'package:laiza/data/repositories/order_repository/order_repository.dart';

part 'earning_state.dart';

class EarningCubit extends Cubit<EarningState> {
  final OrderRepository _orderRepository;

  EarningCubit(this._orderRepository) : super(EarningInitial());

  void fetchInfluencerProduct(String year) async {
    try {
      emit(EarningLoading());
      InfluencerOrderModel influencerOrder =
          await _orderRepository.getInfluencerOrders(year);
      emit(EarningLoaded(influencerOrder));
    } catch (e) {
      emit(EarningError(e.toString()));
    }
  }
}
