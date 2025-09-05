import 'package:flutter/material.dart';
import 'order_tracking_screen.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFFF2C6D), child: Icon(Icons.restaurant, color: Colors.white)),
              title: const Text('Pink Burger House'),
              subtitle: const Text('Status: On the Way'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const OrderTrackingScreen()));
                },
                child: const Text('Track'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

