part of 'seller_info_bloc.dart';

sealed class SellerInfoState extends Equatable {
  const SellerInfoState();
  
  @override
  List<Object> get props => [];
}

final class SellerInfoInitial extends SellerInfoState {}
