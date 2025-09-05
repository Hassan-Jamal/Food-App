import 'package:flutter/material.dart';
import 'admin_list_screen.dart';

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
          children: <Widget>[
            _AdminCard(icon: Icons.people_alt_outlined, title: 'Users', onTap: (BuildContext c) => _open(c, 'Users')),
            _AdminCard(icon: Icons.store_outlined, title: 'Restaurants', onTap: (BuildContext c) => _open(c, 'Restaurants')),
            _AdminCard(icon: Icons.receipt_long_outlined, title: 'Orders', onTap: (BuildContext c) => _open(c, 'Orders')),
            _AdminCard(icon: Icons.category_outlined, title: 'Categories', onTap: (BuildContext c) => _open(c, 'Categories')),
            _AdminCard(icon: Icons.settings_outlined, title: 'Settings', onTap: (BuildContext c) => _open(c, 'Settings')),
            _AdminCard(icon: Icons.insights_outlined, title: 'Reports', onTap: (BuildContext c) => _open(c, 'Reports')),
          ],
        ),
      ),
    );
  }
}

void _open(BuildContext context, String title) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => AdminListScreen(title: title)));
}

class _AdminCard extends StatelessWidget {
  const _AdminCard({required this.icon, required this.title, this.onTap});
  final IconData icon;
  final String title;
  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(context),
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

