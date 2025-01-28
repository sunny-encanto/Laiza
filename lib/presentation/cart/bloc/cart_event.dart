part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class AddItem extends CartEvent {
  final CartModel item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CartEvent {
  final int id;

  const RemoveItem(this.id);

  @override
  List<Object> get props => [id];
}

class IncreaseQuantity extends CartEvent {
  final int id;

  const IncreaseQuantity(this.id);

  @override
  List<Object> get props => [id];
}

class DecreaseQuantity extends CartEvent {
  final int id;

  const DecreaseQuantity(this.id);

  @override
  List<Object> get props => [id];
}

class ToggleSelection extends CartEvent {
  final int id;

  const ToggleSelection(this.id);

  @override
  List<Object> get props => [id];
}

class CheckOutEvent extends CartEvent {
  // final List<CartModel> items;
  // const CheckOutEvent(this.items);

  @override
  List<Object> get props => [];
}
