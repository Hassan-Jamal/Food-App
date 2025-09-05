import 'package:flutter/material.dart';
import 'restaurant_orders_screen.dart';

class RestaurantDashboard extends StatelessWidget {
  const RestaurantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: <Widget>[
            const _DashboardCard(icon: Icons.restaurant_menu, title: 'Menu'),
            _DashboardCard(
              icon: Icons.assignment_turned_in,
              title: 'Orders',
              onTap: (BuildContext context) {
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const RestaurantOrdersScreen()));
              },
            ),
            const _DashboardCard(icon: Icons.bar_chart, title: 'Analytics'),
            const _DashboardCard(icon: Icons.reviews, title: 'Reviews'),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.icon, required this.title, this.onTap});
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

