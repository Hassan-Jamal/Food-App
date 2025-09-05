import 'package:get/get.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/customer/presentation/pages/home_page.dart';
import '../../features/customer/presentation/pages/restaurant_detail_page.dart';
import '../../features/customer/presentation/pages/cart_page.dart';
import '../../features/customer/presentation/pages/checkout_page.dart';
import '../../features/customer/presentation/pages/order_tracking_page.dart';
import '../../features/customer/presentation/pages/order_history_page.dart';
import '../../features/customer/presentation/pages/profile_page.dart';
import '../../features/restaurant/presentation/pages/restaurant_dashboard_page.dart';
import '../../features/restaurant/presentation/pages/menu_management_page.dart';
import '../../features/restaurant/presentation/pages/order_management_page.dart';
import '../../features/restaurant/presentation/pages/analytics_page.dart';
import '../../features/rider/presentation/pages/rider_dashboard_page.dart';
import '../../features/rider/presentation/pages/delivery_requests_page.dart';
import '../../features/rider/presentation/pages/navigation_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/admin/presentation/pages/user_management_page.dart';
import '../../features/admin/presentation/pages/restaurant_management_page.dart';
import '../../features/admin/presentation/pages/analytics_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String restaurantDetail = '/restaurant-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderTracking = '/order-tracking';
  static const String orderHistory = '/order-history';
  static const String profile = '/profile';
  static const String restaurantDashboard = '/restaurant-dashboard';
  static const String menuManagement = '/menu-management';
  static const String orderManagement = '/order-management';
  static const String restaurantAnalytics = '/restaurant-analytics';
  static const String riderDashboard = '/rider-dashboard';
  static const String deliveryRequests = '/delivery-requests';
  static const String navigation = '/navigation';
  static const String adminDashboard = '/admin-dashboard';
  static const String userManagement = '/user-management';
  static const String restaurantManagement = '/restaurant-management';
  static const String adminAnalytics = '/admin-analytics';

  // Route list
  static final List<GetPage> routes = [
    // Splash & Auth
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Customer Routes
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: restaurantDetail,
      page: () => const RestaurantDetailPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: cart,
      page: () => const CartPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: checkout,
      page: () => const CheckoutPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: orderTracking,
      page: () => const OrderTrackingPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: orderHistory,
      page: () => const OrderHistoryPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Restaurant Routes
    GetPage(
      name: restaurantDashboard,
      page: () => const RestaurantDashboardPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: menuManagement,
      page: () => const MenuManagementPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: orderManagement,
      page: () => const OrderManagementPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: restaurantAnalytics,
      page: () => const RestaurantAnalyticsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Rider Routes
    GetPage(
      name: riderDashboard,
      page: () => const RiderDashboardPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: deliveryRequests,
      page: () => const DeliveryRequestsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: navigation,
      page: () => const NavigationPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Admin Routes
    GetPage(
      name: adminDashboard,
      page: () => const AdminDashboardPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: userManagement,
      page: () => const UserManagementPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: restaurantManagement,
      page: () => const RestaurantManagementPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: adminAnalytics,
      page: () => const AdminAnalyticsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
