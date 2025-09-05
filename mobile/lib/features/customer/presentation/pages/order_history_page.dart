import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Order History Page - Coming Soon'),
      ),
    );
  }
}
