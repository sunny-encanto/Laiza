part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class FetchAddressEvent extends AddressEvent {}

class FetchDefaultAddressEvent extends AddressEvent {}
