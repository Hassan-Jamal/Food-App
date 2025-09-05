import 'package:flutter/material.dart';
import 'rider_map_screen.dart';
import 'rider_deliveries_screen.dart';

class RiderDashboard extends StatelessWidget {
  const RiderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rider Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.directions_bike),
            title: const Text('Available Deliveries'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const RiderDeliveriesScreen())),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.person_pin_circle),
            title: const Text('Live Location'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const RiderMapScreen())),
          ),
        ],
      ),
    );
  }
}

