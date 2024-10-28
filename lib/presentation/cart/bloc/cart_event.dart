part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class ToggleSelectAllCartEvent extends CartEvent {
  final bool isSelectedAll;
  const ToggleSelectAllCartEvent(this.isSelectedAll);
  @override
  List<Object> get props => [isSelectedAll];
}

class AddItem extends CartEvent {
  final CartModel item;

  const AddItem(this.item);
}

class RemoveItem extends CartEvent {
  final int id;

  const RemoveItem(this.id);
}

class IncreaseQuantity extends CartEvent {
  final int id;

  const IncreaseQuantity(this.id);
}

class DecreaseQuantity extends CartEvent {
  final int id;

  const DecreaseQuantity(this.id);
}

class ToggleSelection extends CartEvent {
  final int id;

  const ToggleSelection(this.id);
}

class CheckOutEvent extends CartEvent {
  // final List<CartModel> items;
  // const CheckOutEvent(this.items);

  @override
  List<Object> get props => [];
}
