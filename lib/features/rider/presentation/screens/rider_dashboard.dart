import 'package:flutter/material.dart';

class RiderDashboard extends StatelessWidget {
  const RiderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rider Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          ListTile(leading: Icon(Icons.directions_bike), title: Text('Available Deliveries'), trailing: Icon(Icons.chevron_right)),
          Divider(height: 0),
          ListTile(leading: Icon(Icons.blur_on), title: Text('In-progress'), trailing: Icon(Icons.chevron_right)),
          Divider(height: 0),
          ListTile(leading: Icon(Icons.person_pin_circle), title: Text('Live Location'), trailing: Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}

