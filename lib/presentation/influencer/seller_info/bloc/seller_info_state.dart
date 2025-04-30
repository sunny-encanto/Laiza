part of 'seller_info_bloc.dart';

sealed class SellerInfoState extends Equatable {
  const SellerInfoState();

  @override
  List<Object> get props => [];
}

final class SellerInfoInitial extends SellerInfoState {}

final class SellerInfoLoading extends SellerInfoState {}

final class SellerInfoError extends SellerInfoState {
  final String message;

  const SellerInfoError(this.message);

  @override
  List<Object> get props => [message];
}

final class SellerInfoAddConnectionError extends SellerInfoState {
  final String message;

  const SellerInfoAddConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

final class SellerInfoLoaded extends SellerInfoState {
  final SellerDetailsData sellerDetailsData;

  const SellerInfoLoaded(this.sellerDetailsData);

  @override
  List<Object> get props => [sellerDetailsData];
}

final class SellerInfoAddConnection extends SellerInfoState {
  final String isConnected;

  const SellerInfoAddConnection(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}
