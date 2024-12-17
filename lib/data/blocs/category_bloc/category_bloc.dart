import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/category_model/Category.dart';
import 'package:laiza/data/repositories/category_repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  List<Category> categories = <Category>[];
  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<CategoryLoadEvent>(onCategoryLoad);
  }

  FutureOr<void> onCategoryLoad(CategoryEvent event, emit) async {
    try {
      emit(CategoryLoading());
      categories = await _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {}
  }
}
