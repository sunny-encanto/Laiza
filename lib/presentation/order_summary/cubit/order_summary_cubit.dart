import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/coupon_detail_model/coupon_detail_model.dart';

part 'order_summary_state.dart';

class OrderSummaryCubit extends Cubit<OrderSummaryState> {
  OrderSummaryCubit() : super(OrderSummaryInitial());

  void applyCoupon(CouponDetail coupon, num totalPrice) {
    if (coupon.type == 'percent') {
      double result = (totalPrice * coupon.amount) / 100;
      num newTotal = totalPrice - result;
      emit(DiscountAdded(discountPrice: result, totalPrice: newTotal));
    } else {
      num newTotal = totalPrice - coupon.amount;
      emit(DiscountAdded(discountPrice: coupon.amount, totalPrice: newTotal));
    }
  }
}
