import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  bool _initialized = false;

  Future<void> initialize({required String publishableKey}) async {
    if (_initialized) return;
    Stripe.publishableKey = publishableKey;
    _initialized = true;
  }

  Future<void> presentPaymentSheet({required String clientSecret}) async {
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'FoodPanda Clone',
      style: ThemeMode.system,
    ));
    await Stripe.instance.presentPaymentSheet();
  }
}

