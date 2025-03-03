part of 'coupon_bloc.dart';

sealed class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object?> get props => [];
}

class FetchCouponDetailsEvent extends CouponEvent {
  final String code;

  const FetchCouponDetailsEvent(this.code);

  @override
  List<Object?> get props => [code];
}
