part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchResultLoadingState extends SearchState {}

final class SearchProductResultLoadingState extends SearchState {}

final class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState(this.message);
  @override
  List<Object> get props => [message];
}

final class SearchResultLoadedState extends SearchState {
  final List<SearchModel> searchResult;
  const SearchResultLoadedState(this.searchResult);
  @override
  List<Object> get props => [searchResult];
}

final class SearchProductResultLoadedState extends SearchState {
  final List<Product> searchResult;
  const SearchProductResultLoadedState(this.searchResult);
  @override
  List<Object> get props => [searchResult];
}
