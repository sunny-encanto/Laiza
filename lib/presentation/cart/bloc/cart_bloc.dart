import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/cart_model/cart_model.dart';
import 'package:laiza/data/repositories/cart_repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartModel> _cartItemsList = <CartModel>[];
  late CartRepository _cartRepository;

  CartBloc(CartRepository cartRepository)
      : super(const CartState(items: <CartModel>[], isLoading: true)) {
    _cartRepository = cartRepository;
    on<FetchCartEvent>(_onCartLoaded);
    on<AddItem>(_onAddItem);

    on<RemoveItem>(_onRemoveItem);

    on<IncreaseQuantity>(_onIncreaseQuantity);

    on<DecreaseQuantity>(_onDecreaseQuantity);

    on<ToggleSelection>(_onToggleSelection);

    on<CheckOutEvent>(_onCheckOutEvent);
  }

  FutureOr<void> _onCartLoaded(
      FetchCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    _cartItemsList = await _cartRepository.fetchCart();
    emit(state.copyWith(isLoading: false, items: _cartItemsList));
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
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onDecreaseQuantity(event, emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onIncreaseQuantity(event, emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        return item.copyWith(quantity: item.quantity + 1);
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
}
