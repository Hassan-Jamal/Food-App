import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Cart Page - Coming Soon'),
      ),
    );
  }
}
