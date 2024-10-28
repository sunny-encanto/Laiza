part of 'add_address_bloc.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();

  @override
  List<Object> get props => [];
}

final class AddAddressInitial extends AddAddressState {}

final class AddAddressLoadingState extends AddAddressState {}

final class AddAddressErrorState extends AddAddressState {
  final String message;

  const AddAddressErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class AddAddressSuccessState extends AddAddressState {}

final class DefaultAddressToggleState extends AddAddressState {
  final bool isDefault;
  const DefaultAddressToggleState(this.isDefault);
  @override
  List<Object> get props => [isDefault];
}
