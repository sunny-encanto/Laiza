import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<OnPageChangedEvent>(_onPageChangeEvent);
    on<ProductLikeToggleEvent>(onProductLikeToggle);
    on<ProductSizeChangeEvent>(onProductSizeChange);
    on<ProductColorChangeEvent>(onProductColorChange);
  }

  FutureOr<void> _onPageChangeEvent(
      OnPageChangedEvent event, Emitter<ProductDetailState> emit) {
    emit(OnPageChangedState(event.index));
  }

  FutureOr<void> onProductLikeToggle(
      ProductLikeToggleEvent event, Emitter<ProductDetailState> emit) {
    emit(ProductLikeToggleState(event.isLiked));
  }

  FutureOr<void> onProductSizeChange(
      ProductSizeChangeEvent event, Emitter<ProductDetailState> emit) {
    emit(ProductSizeChangeState(event.size));
  }

  FutureOr<void> onProductColorChange(
      ProductColorChangeEvent event, Emitter<ProductDetailState> emit) {
    emit(ProductColorChangeState(event.color));
  }
}
