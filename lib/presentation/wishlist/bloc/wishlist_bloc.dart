import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/wishlist_model/wishlist_model.dart';
import 'package:laiza/data/repositories/wishlist_repository/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  late WishlistRepository _wishlistRepository;
  List<Wishlist> itemList = <Wishlist>[];

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
      RemoveWishListsItemEvent event, Emitter<WishlistState> emit) async {
    try {
      final updatedItems = List<Wishlist>.from(itemList)
        ..removeWhere((item) => item.id == event.id);
      emit(WishlistLoadedState(updatedItems));
      // Update the original itemList to reflect the removal
      itemList = updatedItems;
    } catch (e) {
      emit(const WishlistErrorState('Failed to remove wishlist item'));
    }
  }
}
