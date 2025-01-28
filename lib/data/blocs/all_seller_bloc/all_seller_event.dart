part of 'all_seller_bloc.dart';

sealed class AllSellerEvent extends Equatable {
  const AllSellerEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllSellerEvent extends AllSellerEvent {}
