import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/cart_model/cart_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<FetchWishListsEvent>(_onFetchWishList);
    on<RemoveWishListsItemEvent>(_onWishListItemRemove);
  }
  List<CartModel> itemList = cartItemsList;
  FutureOr<void> _onFetchWishList(
      FetchWishListsEvent event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(WishlistLoadedState(itemList));
    } catch (e) {
      emit(const WishlistErrorState('Failed to load wishlist'));
    }
  }

  FutureOr<void> _onWishListItemRemove(
      RemoveWishListsItemEvent event, Emitter<WishlistState> emit) async {
    try {
      final updatedItems = List<CartModel>.from(itemList)
        ..removeWhere((item) => item.id == event.id);
      emit(WishlistLoadedState(updatedItems));
      // Update the original itemList to reflect the removal
      itemList = updatedItems;
    } catch (e) {
      emit(const WishlistErrorState('Failed to remove wishlist item'));
    }
  }
}
