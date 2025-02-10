import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({
    required double amount,
    required String name,
    required String description,
    required String email,
    required String contact,
    required String orderId, // Optional: For server-side order creation
  }) {
    Map<String, dynamic> options = {
      'key': '<YOUR_RAZORPAY_KEY>',
      'amount': (amount * 100).toInt(), // Convert amount to paise
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
      'order_id': orderId, // Optional
      'theme': {'color': '#3399cc'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment Success: ${response.paymentId}");
    // Handle payment success, e.g., update backend or show success screen
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Error: ${response.code} | ${response.message}");
    // Handle payment failure, e.g., show error message to the user
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet Selected: ${response.walletName}");
    // Handle external wallet selection if needed
  }

  void dispose() {
    _razorpay.clear();
  }
}
