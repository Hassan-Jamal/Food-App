import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/cart_controller.dart';
import 'checkout_screen.dart';

class CustomerCartScreen extends ConsumerWidget {
  const CustomerCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CartState cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final CartItem item = cart.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: cart.items.isEmpty
                ? null
                : () async {
                    if (!context.mounted) return;
                    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const CheckoutScreen()));
                  },
            child: Text('Checkout • \$${cart.total.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}

