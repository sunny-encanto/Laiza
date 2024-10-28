part of 'seller_form_bloc.dart';

sealed class SellerFormState extends Equatable {
  const SellerFormState();

  @override
  List<Object> get props => [];
}

final class SellerFormInitial extends SellerFormState {}

final class SellerFormLoadingState extends SellerFormState {}

final class SellerFormSuccessState extends SellerFormState {}

final class SellerFormErrorState extends SellerFormState {}
