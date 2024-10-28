part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWishListsEvent extends WishlistEvent {}

class RemoveWishListsItemEvent extends WishlistEvent {
  final int id;
  const RemoveWishListsItemEvent(this.id);
  @override
  List<Object> get props => [id];
}
