import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Row(
            children: const <Widget>[
              CircleAvatar(radius: 28, backgroundColor: Color(0xFFFF2C6D), child: Icon(Icons.person, color: Colors.white)),
              SizedBox(width: 12),
              Text('Guest User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: const <Widget>[
                ListTile(leading: Icon(Icons.location_on_outlined), title: Text('Addresses')),
                Divider(height: 0),
                ListTile(leading: Icon(Icons.payment_outlined), title: Text('Payments')),
                Divider(height: 0),
                ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

