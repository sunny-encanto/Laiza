part of 'seller_info_bloc.dart';

sealed class SellerInfoEvent extends Equatable {
  const SellerInfoEvent();

  @override
  List<Object> get props => [];
}

final class FetchSellerInfo extends SellerInfoEvent {
  final String id;

  const FetchSellerInfo(this.id);

  @override
  List<Object> get props => [id];
}

final class SellerInfoAddConnectionEvent extends SellerInfoEvent {
  final String isConnected;
  final int id;

  const SellerInfoAddConnectionEvent(
      {required this.isConnected, required this.id});

  @override
  List<Object> get props => [isConnected, id];
}
