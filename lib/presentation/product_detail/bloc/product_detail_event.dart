part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailLoadEvent extends ProductDetailEvent {
  final int id;

  const ProductDetailLoadEvent(this.id);

  @override
  List<Object> get props => [id];
}

class OnPageChangedEvent extends ProductDetailEvent {
  final int index;

  const OnPageChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class ProductLikeToggleEvent extends ProductDetailEvent {
  final bool isLiked;
  final int id;

  const ProductLikeToggleEvent({required this.isLiked, required this.id});

  @override
  List<Object> get props => [isLiked];
}

class ProductSizeChangeEvent extends ProductDetailEvent {
  final String size;
  final List<Inventory> inventory;

  const ProductSizeChangeEvent({required this.size, required this.inventory});

  @override
  List<Object> get props => [size];
}

class ProductColorChangeEvent extends ProductDetailEvent {
  final int color;

  const ProductColorChangeEvent(this.color);

  @override
  List<Object> get props => [color];
}

class ProductAddToCart extends ProductDetailEvent {
  final int id;

  const ProductAddToCart(this.id);

  @override
  List<Object> get props => [id];
}

class SelectSizeEvent extends ProductDetailEvent {
  final String selectedSize;

  const SelectSizeEvent(this.selectedSize);

  @override
  List<Object> get props => [selectedSize];
}
