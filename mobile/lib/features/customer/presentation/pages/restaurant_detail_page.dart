import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Details'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Restaurant Detail Page - Coming Soon'),
      ),
    );
  }
}
