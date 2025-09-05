import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/services/firebase_service.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/restaurant_provider.dart';
import 'core/providers/order_provider.dart';
import 'core/providers/cart_provider.dart';
import 'core/providers/location_provider.dart';
import 'core/providers/notification_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize Firebase services
  await FirebaseService.initialize();
  
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: GetMaterialApp(
        title: 'Food Delivery App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
