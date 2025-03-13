import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  // Callbacks for payment events
  final Function(PaymentSuccessResponse) onSuccess;
  final Function(PaymentFailureResponse) onError;
  final Function(ExternalWalletResponse) onExternalWallet;

  RazorpayService({
    required this.onSuccess,
    required this.onError,
    required this.onExternalWallet,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout({
    required int amount,
    required String name,
    required String description,
    String? contact,
    String? email,
  }) {
    var options = {
      'key': 'rzp_test_TrNh2WzyBi5Cbt',
      'amount': (amount * 100).toInt(),
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact ?? '',
        'email': email ?? '',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay checkout: $e");
    }
  }

  void clear() {
    _razorpay.clear(); // Remove event listeners
  }
}
