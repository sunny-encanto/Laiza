part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class ResetPagination extends ProductEvent {}

class ToggleWishListEvent extends ProductEvent {
  final int id;

  const ToggleWishListEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AskForPromotionEvent extends ProductEvent {
  final int id;

  const AskForPromotionEvent(this.id);

  @override
  List<Object?> get props => [id];
}
