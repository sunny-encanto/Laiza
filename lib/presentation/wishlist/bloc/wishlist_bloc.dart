import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/wishlist_model/wishlist_model.dart';
import 'package:laiza/data/repositories/wishlist_repository/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  late WishlistRepository _wishlistRepository;
  List<WishlistData> itemList = <WishlistData>[];

  WishlistBloc(WishlistRepository wishlistRepository)
      : super(WishlistInitial()) {
    _wishlistRepository = wishlistRepository;
    on<FetchWishListsEvent>(_onFetchWishList);
    on<RemoveWishListsItemEvent>(_onWishListItemRemove);
  }

  FutureOr<void> _onFetchWishList(
      FetchWishListsEvent event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistLoadingState());
      itemList = await _wishlistRepository.fetchWishList();
      emit(WishlistLoadedState(itemList));
    } catch (e) {
      emit(const WishlistErrorState('Failed to load wishlist'));
    }
  }

  FutureOr<void> _onWishListItemRemove(
    RemoveWishListsItemEvent event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      // Emit loading state if necessary
      emit(WishlistLoadingState());
      final updatedItems = <WishlistData>[];
      for (final item in itemList) {
        if (item.product.id == event.id) {
          await _wishlistRepository.removeFromWishList(event.id);
        } else {
          updatedItems.add(item);
        }
      }
      emit(WishlistLoadedState(updatedItems));
      // Update the original itemList
      itemList = updatedItems;
    } catch (e) {
      // Emit error state if something goes wrong
      emit(WishlistErrorState(
          'Failed to remove wishlist item: ${e.toString()}'));
    }
  }
}
