part of 'address_type_bloc.dart';

sealed class AddressTypeEvent extends Equatable {
  const AddressTypeEvent();

  @override
  List<Object?> get props => [];
}

class FetchAddressTypeEvent extends AddressTypeEvent {}
