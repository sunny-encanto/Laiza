part of 'coupon_bloc.dart';

sealed class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

final class CouponInitial extends CouponState {}

final class CouponLoading extends CouponState {}

final class CouponLoaded extends CouponState {
  final CouponDetail couponDetail;

  const CouponLoaded(this.couponDetail);

  @override
  List<Object> get props => [couponDetail];
}

final class CouponError extends CouponState {
  final String message;

  const CouponError(this.message);

  @override
  List<Object> get props => [message];
}
