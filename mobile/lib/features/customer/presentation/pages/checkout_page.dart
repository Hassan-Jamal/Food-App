import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Checkout Page - Coming Soon'),
      ),
    );
  }
}
