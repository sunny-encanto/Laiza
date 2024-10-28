part of 'discover_bloc.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

final class DiscoverInitial extends DiscoverState {}

final class DiscoverChipSelectState extends DiscoverState {
  final int selectedIndex;
  const DiscoverChipSelectState(this.selectedIndex);
  @override
  List<Object> get props => [selectedIndex];
}
