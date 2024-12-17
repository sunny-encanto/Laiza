part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded(this.category);
  final List<Category> category;

  @override
  List<Object> get props => [category];
}
