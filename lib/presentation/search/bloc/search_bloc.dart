import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/search_model/search_model.dart';

import '../../../data/models/product_model/product.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/repositories/product_repository/product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserRepository _userRepository;
  final ProductRepository _productRepository = ProductRepository();
  List<SearchModel> filteredList = <SearchModel>[];
  List<Product> filteredProductList = <Product>[];
  List<SearchModel> searchResult = <SearchModel>[];
  List<Product> productList = <Product>[];

  SearchBloc(this._userRepository) : super(SearchInitial()) {
    on<SearchUserInteractionEvent>(_onSearchUserInteraction);
    on<SearchProductInteractionEvent>(_onSearchProductInteraction);
    on<FetchSearchItems>(_onFetchSearchItems);
    on<FetchSearchItemsProducts>(_onFetchSearchItemsProducts);
  }

  FutureOr<void> _onSearchUserInteraction(
      SearchUserInteractionEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchResultLoadingState());
      filteredList = searchResult
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(SearchResultLoadedState(filteredList));
    } catch (e) {
      emit(SearchErrorState('Failed to Search $e'));
    }
  }

  FutureOr<void> _onFetchSearchItems(
      FetchSearchItems event, Emitter<SearchState> emit) async {
    emit(SearchResultLoadingState());

    List<UserModel> users = await _userRepository.getAllInfluencer();
    searchResult = users
        .map((e) => SearchModel(
            id: int.parse(e.id ?? ""),
            name: e.name ?? '',
            followersCount: e.followersCount.toString(),
            profile: e.profileImg ?? ''))
        .toList();
    emit(SearchResultLoadedState(searchResult));
  }

  FutureOr<void> _onFetchSearchItemsProducts(
      FetchSearchItemsProducts event, Emitter<SearchState> emit) async {
    emit(SearchProductResultLoadingState());
    productList = await _productRepository.getAllProduct();
    emit(SearchProductResultLoadedState(productList));
  }

  FutureOr<void> _onSearchProductInteraction(
      SearchProductInteractionEvent event, Emitter<SearchState> emit) async {
    try {
      filteredProductList = productList
          .where((element) => element.productName
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(SearchProductResultLoadedState(filteredProductList));
    } catch (e) {
      emit(SearchErrorState('Failed to Search $e'));
    }
  }
}
