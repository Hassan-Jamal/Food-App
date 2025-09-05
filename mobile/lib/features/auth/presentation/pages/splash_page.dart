import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/loading_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkAuthStatus();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      if (authProvider.isAuthenticated) {
        _navigateToHome();
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
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
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPink,
              AppColors.primaryPinkDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            size: 60,
                            color: AppColors.primaryPink,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // App Name
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'FoodPanda Clone',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Tagline
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Delicious food delivered to your door',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 80),
                
                // Loading Indicator
                const LoadingWidget(
                  message: 'Loading...',
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
