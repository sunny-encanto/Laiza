part of 'creator_bloc.dart';

sealed class CreatorEvent extends Equatable {
  const CreatorEvent();

  @override
  List<Object> get props => [];
}

class CreatorsCategoryChipSelectedEvent extends CreatorEvent {
  final int categoryId;
  const CreatorsCategoryChipSelectedEvent(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}
