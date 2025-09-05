import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('User Management - Coming Soon'),
      ),
    );
  }
}
