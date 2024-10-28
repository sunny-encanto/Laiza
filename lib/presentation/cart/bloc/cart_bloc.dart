import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/cart_model/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(items: <CartModel>[], isLoading: true)) {
    on<FetchCartEvent>(_onCartLoaded);
    on<AddItem>(_onAddItem);

    on<RemoveItem>(_onRemoveItem);

    on<IncreaseQuantity>(_onIncreaseQuantity);

    on<DecreaseQuantity>(_onDecreaseQuantity);

    on<ToggleSelection>(_onToggleSelection);

    on<CheckOutEvent>(_onCheckOutEvent);
  }

  FutureOr<void> _onCheckOutEvent(event, emit) {
    final selectedItems = state.items.where((item) => item.isSelected).toList();

    if (selectedItems.isEmpty) {
      emit(state.copyWith(errorMessage: 'No items selected for checkout.'));
    } else {
      emit(state.copyWith(errorMessage: null));
    }
  }

  FutureOr<void> _onToggleSelection(event, emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        return item..isSelected = !item.isSelected;
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onDecreaseQuantity(event, emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id && item.quantity > 1) {
        // Return a new CartItem with the updated quantity
        return CartModel(
          url: item.url,
          id: item.id,
          name: item.name,
          price: item.price,
          quantity: item.quantity - 1,
          isSelected: item.isSelected,
        );
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onIncreaseQuantity(event, emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        // Return a new CartItem with the updated quantity
        return CartModel(
          url: item.url,
          id: item.id,
          name: item.name,
          price: item.price,
          quantity: item.quantity + 1,
          isSelected: item.isSelected,
        );
      }
      return item;
    }).toList();

    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onRemoveItem(event, emit) {
    final updatedItems = List<CartModel>.from(state.items)
      ..removeWhere((item) => item.id == event.id);
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onAddItem(event, emit) {
    final updatedItems = List<CartModel>.from(state.items)..add(event.item);
    emit(_calculateCart(updatedItems));
  }

  CartState _calculateCart(List<CartModel> updatedItems) {
    final selectedItems =
        updatedItems.where((item) => item.isSelected).toList();
    final totalPrice = selectedItems.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
    final selectedItemCount = selectedItems.length;

    return state.copyWith(
      items: updatedItems,
      totalPrice: totalPrice,
      selectedItemCount: selectedItemCount,
    );
  }

  FutureOr<void> _onCartLoaded(
      FetchCartEvent event, Emitter<CartState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false, items: cartItemsList));
  }
}
