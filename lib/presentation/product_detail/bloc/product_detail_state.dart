part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class OnPageChangedState extends ProductDetailState {
  final int index;
  const OnPageChangedState(this.index);
}

class ProductLikeToggleState extends ProductDetailState {
  final bool isLiked;
  const ProductLikeToggleState(this.isLiked);
  @override
  List<Object> get props => [isLiked];
}

class ProductSizeChangeState extends ProductDetailState {
  final int size;
  const ProductSizeChangeState(this.size);
  @override
  List<Object> get props => [size];
}

class ProductColorChangeState extends ProductDetailState {
  final int color;
  const ProductColorChangeState(this.color);
  @override
  List<Object> get props => [color];
}
