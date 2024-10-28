part of 'creator_bloc.dart';

sealed class CreatorState extends Equatable {
  const CreatorState();

  @override
  List<Object> get props => [];
}

final class CreatorInitial extends CreatorState {}

class CreatorsCategoryChipSelectedState extends CreatorState {
  final int categoryId;
  const CreatorsCategoryChipSelectedState(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}
