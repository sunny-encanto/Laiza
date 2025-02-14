import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';

import '../../models/product_model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final int _pageSize = 10; // Number of items per page
  int _currentPage = 1;
  bool _hasMore = true;
  List<Product> products = <Product>[];

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ResetPagination>(_onResetPagination);
    on<ToggleWishListEvent>(_onToggleWishList);
    on<AskForPromotionEvent>(_onAskForPromotion);
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      products = await _productRepository.getAllProduct();
      _hasMore = products.length == _pageSize;
      emit(ProductLoaded(products: products, hasMore: _hasMore));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onResetPagination(
      ResetPagination event, Emitter<ProductState> emit) async {
    _currentPage = 1;
    _hasMore = true;
    emit(ProductInitial());
  }

  FutureOr<void> _onToggleWishList(
      ToggleWishListEvent event, Emitter<ProductState> emit) async {
    products = products.map((item) {
      if (item.id == event.id) {
        if (item.isAddedToWishlist) {
          WishlistRepository().removeFromWishList(event.id);
        } else {
          WishlistRepository().addToWishList(event.id);
        }
        return item.copyWith(isAddedToWishlist: !item.isAddedToWishlist);
      }
      return item;
    }).toList();
    emit(ProductLoaded(products: products, hasMore: _hasMore));
  }

  FutureOr<void> _onAskForPromotion(
      AskForPromotionEvent event, Emitter<ProductState> emit) async {
    products = products.map((item) {
      if (item.id == event.id) {
        _productRepository.askForPromotion(event.id);
        return item.copyWith(isAsked: !item.isAsked);
      }
      return item;
    }).toList();
    emit(ProductLoaded(products: products, hasMore: _hasMore));
  }
}
