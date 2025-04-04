import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';

import '../../../data/models/common_model/common_model.dart';
import '../../../data/models/product_model/product.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository _productRepository;
  final WishlistRepository _wishlistRepository = WishlistRepository();
  final CartRepository _cartRepository = CartRepository();

  ProductDetailBloc(this._productRepository) : super(ProductDetailInitial()) {
    on<OnPageChangedEvent>(_onPageChangeEvent);
    on<ProductLikeToggleEvent>(onProductLikeToggle);
    on<ProductSizeChangeEvent>(onProductSizeChange);
    on<ProductColorChangeEvent>(onProductColorChange);
    on<ProductDetailLoadEvent>(_onProductDetailLoad);
    on<ProductAddToCart>(_onProductAddedInCart);
  }

  FutureOr<void> _onPageChangeEvent(
      OnPageChangedEvent event, Emitter<ProductDetailState> emit) {
    emit(OnPageChangedState(event.index));
  }

  FutureOr<void> onProductLikeToggle(
      ProductLikeToggleEvent event, Emitter<ProductDetailState> emit) {
    if (event.isLiked) {
      _wishlistRepository.addToWishList(event.id);
    } else {
      _wishlistRepository.removeFromWishList(event.id);
    }
    emit(ProductLikeToggleState(event.isLiked));
  }

  FutureOr<void> onProductSizeChange(
      ProductSizeChangeEvent event, Emitter<ProductDetailState> emit) {
    final List<Inventory> filteredInventory =
        event.inventory.where((item) => item.size == event.size).toList();
    emit(
        ProductSizeChangeState(size: event.size, inventory: filteredInventory));
  }

  FutureOr<void> onProductColorChange(
      ProductColorChangeEvent event, Emitter<ProductDetailState> emit) {
    emit(ProductColorChangeState(event.color));
  }

  FutureOr<void> _onProductDetailLoad(
      ProductDetailLoadEvent event, Emitter<ProductDetailState> emit) async {
    try {
      emit(ProductDetailLoading());
      Product product = await _productRepository.getProductDetail(event.id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }

  FutureOr<void> _onProductAddedInCart(
      ProductAddToCart event, Emitter<ProductDetailState> emit) async {
    try {
      emit(ProductAddToCartLoading());
      CommonModel model = await _cartRepository.addToCart(
          id: event.id, quantity: 1, inventoryId: event.inventoryId);
      emit(ProductAddedToCart(model.message ?? ''));
    } catch (e) {
      emit(ProductAddedToCartError(e.toString()));
    }
  }
}
