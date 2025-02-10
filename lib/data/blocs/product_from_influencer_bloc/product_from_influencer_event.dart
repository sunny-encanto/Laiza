part of 'product_from_influencer_bloc.dart';

sealed class ProductFromInfluencerEvent extends Equatable {
  const ProductFromInfluencerEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductFromInfluencer extends ProductFromInfluencerEvent {}
