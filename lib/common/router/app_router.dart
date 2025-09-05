import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/customer/presentation/screens/customer_shell.dart';
import '../../features/restaurant/presentation/screens/restaurant_dashboard.dart';
import '../../features/rider/presentation/screens/rider_dashboard.dart';
import '../../features/admin/presentation/screens/admin_dashboard.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
      ),
      // Role dashboards
      GoRoute(
        path: '/customer',
        builder: (BuildContext context, GoRouterState state) => const CustomerShell(),
      ),
      GoRoute(
        path: '/restaurant',
        builder: (BuildContext context, GoRouterState state) => const RestaurantDashboard(),
      ),
      GoRoute(
        path: '/rider',
        builder: (BuildContext context, GoRouterState state) => const RiderDashboard(),
      ),
      GoRoute(
        path: '/admin',
        builder: (BuildContext context, GoRouterState state) => const AdminDashboard(),
      ),
    ],
  );
});

