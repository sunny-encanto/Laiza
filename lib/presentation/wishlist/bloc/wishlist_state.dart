part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistLoadedState extends WishlistState {
  final List<Wishlist> items;
  const WishlistLoadedState(this.items);

  @override
  List<Object> get props => [items];
}

final class WishlistErrorState extends WishlistState {
  final String message;
  const WishlistErrorState(this.message);
  @override
  List<Object> get props => [message];
}
