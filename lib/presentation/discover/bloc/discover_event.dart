part of 'discover_bloc.dart';

sealed class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class DiscoverChipSelectEvent extends DiscoverEvent {
  final int selectedIndex;
  const DiscoverChipSelectEvent(this.selectedIndex);
  @override
  List<Object> get props => [selectedIndex];
}
