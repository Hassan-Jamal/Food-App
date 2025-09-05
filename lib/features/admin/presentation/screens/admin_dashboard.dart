import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: const <Widget>[
            _AdminCard(icon: Icons.people_alt_outlined, title: 'Users'),
            _AdminCard(icon: Icons.store_outlined, title: 'Restaurants'),
            _AdminCard(icon: Icons.receipt_long_outlined, title: 'Orders'),
            _AdminCard(icon: Icons.category_outlined, title: 'Categories'),
            _AdminCard(icon: Icons.settings_outlined, title: 'Settings'),
            _AdminCard(icon: Icons.insights_outlined, title: 'Reports'),
          ],
        ),
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  const _AdminCard({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 36, color: const Color(0xFFFF2C6D)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

