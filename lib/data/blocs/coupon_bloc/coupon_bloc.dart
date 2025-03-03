import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/coupon_detail_model/coupon_detail_model.dart';
import 'package:laiza/data/repositories/coupon_repository/coupon_repository.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRepository _couponRepository;

  CouponBloc(this._couponRepository) : super(CouponInitial()) {
    on<FetchCouponDetailsEvent>(_onFetchCouponDetail);
  }

  FutureOr<void> _onFetchCouponDetail(
      FetchCouponDetailsEvent event, Emitter<CouponState> emit) async {
    try {
      emit(CouponLoading());
      CouponDetail couponDetail =
          await _couponRepository.getCouponDetail(event.code);
      emit(CouponLoaded(couponDetail));
    } catch (e) {
      emit(CouponError(e.toString()));
    }
  }
}
