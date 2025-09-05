import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/order_success_animation.dart';
import '../../application/cart_controller.dart';
import '../../../common/services/stripe_service.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _processing = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final CartState cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Total: \$${cart.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            TextField(decoration: const InputDecoration(labelText: 'Delivery Address')),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processing
                    ? null
                    : () async {
                        setState(() => _processing = true);
                        try {
                          await StripeService.instance.initialize(publishableKey: 'pk_test_your_key_here');
                          // In a real app, fetch a PaymentIntent client secret from your backend.
                          // For demo, this will throw but we still show success animation.
                          await StripeService.instance.presentPaymentSheet(clientSecret: 'pi_test_client_secret');
                          if (!mounted) return;
                          await showDialog<void>(
                            context: context,
                            builder: (_) => const Dialog(child: Padding(padding: EdgeInsets.all(16), child: OrderSuccessAnimation())),
                          );
                          ref.read(cartProvider.notifier).clear();
                          if (!mounted) return;
                          Navigator.of(context).pop();
                        } catch (e) {
                          setState(() => _error = 'Stripe not configured. Simulating success.');
                          if (!mounted) return;
                          await showDialog<void>(
                            context: context,
                            builder: (_) => const Dialog(child: Padding(padding: EdgeInsets.all(16), child: OrderSuccessAnimation())),
                          );
                          ref.read(cartProvider.notifier).clear();
                          if (!mounted) return;
                          Navigator.of(context).pop();
                        } finally {
                          if (mounted) setState(() => _processing = false);
                        }
                      },
                child: _processing ? const CircularProgressIndicator.adaptive() : const Text('Pay with Card (Test)')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

