part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserInteractionEvent extends SearchEvent {
  final String query;

  const SearchUserInteractionEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SearchProductInteractionEvent extends SearchEvent {
  final String query;

  const SearchProductInteractionEvent(this.query);

  @override
  List<Object> get props => [query];
}

class FetchSearchItems extends SearchEvent {
  final bool isSearchSeller;

  const FetchSearchItems(this.isSearchSeller);

  @override
  List<Object> get props => [isSearchSeller];
}

class FetchSearchItemsProducts extends SearchEvent {}
