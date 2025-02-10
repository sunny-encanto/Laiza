import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';

part 'product_from_influencer_event.dart';
part 'product_from_influencer_state.dart';

class ProductFromInfluencerBloc
    extends Bloc<ProductFromInfluencerEvent, ProductFromInfluencerState> {
  final ProductRepository _productRepository;

  ProductFromInfluencerBloc(this._productRepository)
      : super(ProductFromInfluencerInitial()) {
    on<FetchProductFromInfluencer>(_onFetchProductFromInfluencer);
  }

  FutureOr<void> _onFetchProductFromInfluencer(FetchProductFromInfluencer event,
      Emitter<ProductFromInfluencerState> emit) async {
    try {
      emit(ProductFromInfluencerLoading());
      List<Reel> reels = await _productRepository.getAllInfluencerProduct();
      List<ReelProduct> products = <ReelProduct>[];
      for (Reel reel in reels) {
        products.addAll(reel.product);
      }
      emit(ProductFromInfluencerLoaded(products));
    } catch (e) {
      emit(ProductFromInfluencerError(e.toString()));
    }
  }
}
