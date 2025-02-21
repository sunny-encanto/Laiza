import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/cart_model/cart_model.dart';
import 'package:laiza/data/repositories/cart_repository/cart_repository.dart';

import '../../../data/models/wishlist_model/wishlist_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel> _cartItemsList = <CartModel>[];
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
    List<WishlistData> data = await _cartRepository.fetchCart();
    _cartItemsList.clear();
    for (var item in data) {
      _cartItemsList.add(
        CartModel(
          cartId: item.id,
          id: item.productId,
          url: item.product.images[0].imagePath,
          price: double.parse(item.product.price),
          quantity: item.quantity,
          name: item.product.productName,
          isSelected: true,
        ),
      );
    }
    final totalPrice = _cartItemsList.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
    emit(state.copyWith(
        isLoading: false, items: _cartItemsList, totalPrice: totalPrice));
  }

  FutureOr<void> _onCheckOutEvent(event, emit) {
    final List<CartModel> selectedItems =
        state.items.where((item) => item.isSelected).toList();

    if (selectedItems.isEmpty) {
      emit(state.copyWith(errorMessage: 'No items selected for checkout.'));
    } else {
      emit(state.copyWith(errorMessage: null));
    }
  }

  FutureOr<void> _onToggleSelection(event, emit) {
    final List<CartModel> updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onDecreaseQuantity(event, emit) {
    final List<CartModel> updatedItems = state.items.map((item) {
      if (item.id == event.id && item.quantity > 1) {
        _cartRepository.updateCart(cartId: item.cartId, quantity: -1);
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onIncreaseQuantity(event, emit) {
    final List<CartModel> updatedItems = state.items.map((item) {
      if (item.id == event.id) {
        _cartRepository.updateCart(cartId: item.cartId, quantity: 1);
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onRemoveItem(event, emit) {
    final List<CartModel> updatedItems = [];
    for (var item in state.items) {
      if (item.id == event.id) {
        _cartRepository.removeFromCart(cartId: item.cartId);
      } else {
        updatedItems.add(item);
      }
    }
    // List<CartModel>.from(state.items)
    //   ..removeWhere((item) => item.id == event.id);
    emit(_calculateCart(updatedItems));
  }

  FutureOr<void> _onAddItem(event, emit) {
    final List<CartModel> updatedItems = List<CartModel>.from(state.items)
      ..add(event.item);
    emit(_calculateCart(updatedItems));
  }

  CartState _calculateCart(List<CartModel> updatedItems) {
    final List<CartModel> selectedItems =
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
