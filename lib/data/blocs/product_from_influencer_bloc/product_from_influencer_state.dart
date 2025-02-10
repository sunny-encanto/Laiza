part of 'product_from_influencer_bloc.dart';

sealed class ProductFromInfluencerState extends Equatable {
  const ProductFromInfluencerState();

  @override
  List<Object> get props => [];
}

final class ProductFromInfluencerInitial extends ProductFromInfluencerState {}

final class ProductFromInfluencerLoading extends ProductFromInfluencerState {}

final class ProductFromInfluencerLoaded extends ProductFromInfluencerState {
  final List<ReelProduct> products;

  const ProductFromInfluencerLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductFromInfluencerError extends ProductFromInfluencerState {
  final String message;

  const ProductFromInfluencerError(this.message);

  @override
  List<Object> get props => [message];
}
