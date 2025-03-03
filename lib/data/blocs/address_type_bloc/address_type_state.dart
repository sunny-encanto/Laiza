part of 'address_type_bloc.dart';

sealed class AddressTypeState extends Equatable {
  const AddressTypeState();

  @override
  List<Object> get props => [];
}

final class AddressTypeInitial extends AddressTypeState {}

final class AddressTypeLoading extends AddressTypeState {}

final class AddressTypeLoaded extends AddressTypeState {
  final List<AddressType> addressType;

  const AddressTypeLoaded(this.addressType);

  @override
  List<Object> get props => [addressType];
}

final class AddressTypeError extends AddressTypeState {
  final String message;

  const AddressTypeError(this.message);

  @override
  List<Object> get props => [message];
}
