import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../widgets/role_selector.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'customer';
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      _navigateToHome();
    } else if (mounted) {
      _showErrorSnackBar(authProvider.errorMessage ?? 'Login failed');
    }
  }

  void _navigateToHome() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isCustomer) {
      Get.offAllNamed(AppRoutes.home);
    } else if (authProvider.isRestaurant) {
      Get.offAllNamed(AppRoutes.restaurantDashboard);
    } else if (authProvider.isRider) {
      Get.offAllNamed(AppRoutes.riderDashboard);
    } else if (authProvider.isAdmin) {
      Get.offAllNamed(AppRoutes.adminDashboard);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo and Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Role Selector
                RoleSelector(
                  selectedRole: _selectedRole,
                  onRoleChanged: (role) {
                    setState(() {
                      _selectedRole = role;
                    });
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Email Field
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.textMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Password Field
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: AppColors.textMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryPink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Login Button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CustomButton(
                      text: 'Sign In',
                      onPressed: authProvider.isLoading ? null : _handleLogin,
                      isLoading: authProvider.isLoading,
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Demo Credentials
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPinkLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryPinkLight.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Demo Credentials:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Customer: customer@demo.com / 123456\nRestaurant: restaurant@demo.com / 123456\nRider: rider@demo.com / 123456\nAdmin: admin@demo.com / 123456',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
