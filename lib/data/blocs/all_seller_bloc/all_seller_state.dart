part of 'all_seller_bloc.dart';

sealed class AllSellerState extends Equatable {
  const AllSellerState();

  @override
  List<Object> get props => [];
}

final class AllSellerInitial extends AllSellerState {}

final class AllSellerLoading extends AllSellerState {}

final class AllSellerLoaded extends AllSellerState {
  final List<UserModel> sellers;

  const AllSellerLoaded(this.sellers);

  @override
  List<Object> get props => [sellers];
}

final class AllSellerError extends AllSellerState {
  final String message;

  const AllSellerError(this.message);

  @override
  List<Object> get props => [message];
}
