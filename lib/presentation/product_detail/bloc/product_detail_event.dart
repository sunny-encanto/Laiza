part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class OnPageChangedEvent extends ProductDetailEvent {
  final int index;
  const OnPageChangedEvent(this.index);
  @override
  List<Object> get props => [index];
}

class ProductLikeToggleEvent extends ProductDetailEvent {
  final bool isLiked;
  const ProductLikeToggleEvent(this.isLiked);
  @override
  List<Object> get props => [isLiked];
}

class ProductSizeChangeEvent extends ProductDetailEvent {
  final int size;
  const ProductSizeChangeEvent(this.size);
  @override
  List<Object> get props => [size];
}

class ProductColorChangeEvent extends ProductDetailEvent {
  final int color;
  const ProductColorChangeEvent(this.color);
  @override
  List<Object> get props => [color];
}
