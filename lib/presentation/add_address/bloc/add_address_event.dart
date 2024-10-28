part of 'add_address_bloc.dart';

sealed class AddAddressEvent extends Equatable {
  const AddAddressEvent();

  @override
  List<Object?> get props => [];
}

class AddAddressSubmitEvent extends AddAddressEvent {
  final String address;
  final bool isDefault;

  const AddAddressSubmitEvent({required this.address, required this.isDefault});

  @override
  List<Object?> get props => [address, isDefault];
}

class DefaultAddressToggleEvent extends AddAddressEvent {
  final bool isDefault;

  const DefaultAddressToggleEvent(this.isDefault);

  @override
  List<Object?> get props => [isDefault];
}
