import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryPink,
              ),
            );
          }

          final user = authProvider.currentUser;
          if (user == null) {
            return const Center(
              child: Text('No user data available'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPink,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: user.profileImageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            user.profileImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                ),
                
                const SizedBox(height: 20),
                
                // User Name
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // User Email
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // User Role
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPinkLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.role.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Profile Options
                _buildProfileOption(
                  context,
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    // TODO: Navigate to edit profile
                  },
                ),
                
                _buildProfileOption(
                  context,
                  icon: Icons.location_on_outlined,
                  title: 'Addresses',
                  onTap: () {
                    // TODO: Navigate to addresses
                  },
                ),
                
                _buildProfileOption(
                  context,
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () {
                    // TODO: Navigate to payment methods
                  },
                ),
                
                _buildProfileOption(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    // TODO: Navigate to notifications
                  },
                ),
                
                _buildProfileOption(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    // TODO: Navigate to help
                  },
                ),
                
                _buildProfileOption(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    // TODO: Navigate to about
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Logout Button
                CustomButton(
                  text: 'Logout',
                  onPressed: () => _showLogoutDialog(context),
                  isOutlined: true,
                  textColor: AppColors.errorRed,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primaryPink,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textDark,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.textLight,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).signOut();
              Get.offAllNamed('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
