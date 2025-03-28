import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/coupon_detail_model/coupon_detail_model.dart';

part 'order_summary_state.dart';

class OrderSummaryCubit extends Cubit<OrderSummaryState> {
  OrderSummaryCubit() : super(OrderSummaryInitial());

  void applyCoupon(CouponDetail coupon, num totalPrice) {
    num newTotal = totalPrice = coupon.amount;
    emit(DiscountAdded(discountPrice: coupon.amount, totalPrice: newTotal));
  }
}
