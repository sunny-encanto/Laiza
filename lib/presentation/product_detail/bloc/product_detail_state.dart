part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  const ProductDetailLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductDetailError extends ProductDetailState {
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class OnPageChangedState extends ProductDetailState {
  final int index;

  const OnPageChangedState(this.index);

  @override
  List<Object> get props => [index];
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

final class ProductAddedToCart extends ProductDetailState {
  final String message;

  const ProductAddedToCart(this.message);

  @override
  List<Object> get props => [message];
}

final class ProductAddedToCartError extends ProductDetailState {
  final String message;

  const ProductAddedToCartError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProductAddToCartLoading extends ProductDetailState {}
