part of 'seller_form_bloc.dart';

sealed class SellerFormEvent extends Equatable {
  const SellerFormEvent();

  @override
  List<Object> get props => [];
}

final class SellerFormSubmitEvent extends SellerFormEvent {}
