part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartModel> items;
  final int selectedItemCount;
  final double totalPrice;
  final String? errorMessage;
  final bool checkoutSuccess;
  final bool? isLoading;
  const CartState({
    required this.items,
    this.selectedItemCount = 0,
    this.totalPrice = 0.0,
    this.errorMessage,
    this.checkoutSuccess = false,
    this.isLoading,
  });

  CartState copyWith({
    List<CartModel>? items,
    int? selectedItemCount,
    double? totalPrice,
    String? errorMessage,
    bool? checkoutSuccess,
    final bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      selectedItemCount: selectedItemCount ?? this.selectedItemCount,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: errorMessage ?? this.errorMessage,
      checkoutSuccess: checkoutSuccess ?? this.checkoutSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        items,
        selectedItemCount,
        totalPrice,
        errorMessage,
        checkoutSuccess,
        isLoading,
      ];
}
