import 'package:flutter/material.dart';

class RiderDeliveriesScreen extends StatelessWidget {
  const RiderDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Deliveries')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: ListTile(
              title: Text('Order #${1200 + i}'),
              subtitle: const Text('Pickup: Pink Burger House  •  Drop: 123 Main St'),
              trailing: ElevatedButton(onPressed: () {}, child: const Text('Accept')),
            ),
          );
        },
      ),
    );
  }
}

