import 'package:flutter/material.dart';

class RestaurantOrdersScreen extends StatefulWidget {
  const RestaurantOrdersScreen({super.key});

  @override
  State<RestaurantOrdersScreen> createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends State<RestaurantOrdersScreen> {
  String _status = 'pending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Orders')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: ListTile(
              title: Text('Order #${1000 + i}'),
              subtitle: Text('Status: $_status'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    onPressed: () => setState(() => _status = 'accepted'),
                    child: const Text('Accept'),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _status = 'rejected'),
                    child: const Text('Reject'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

