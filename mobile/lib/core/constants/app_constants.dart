class AppConstants {
  // App Information
  static const String appName = 'FoodPanda Clone';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const String baseUrl = 'https://api.fooddeliveryapp.com';
  static const String apiVersion = '/v1';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String restaurantsCollection = 'restaurants';
  static const String dishesCollection = 'dishes';
  static const String ordersCollection = 'orders';
  static const String reviewsCollection = 'reviews';
  static const String categoriesCollection = 'categories';
  static const String ridersCollection = 'riders';
  static const String notificationsCollection = 'notifications';
  
  // User Roles
  static const String customerRole = 'customer';
  static const String restaurantRole = 'restaurant';
  static const String riderRole = 'rider';
  static const String adminRole = 'admin';
  
  // Order Status
  static const String orderPlaced = 'placed';
  static const String orderAccepted = 'accepted';
  static const String orderPreparing = 'preparing';
  static const String orderReady = 'ready';
  static const String orderPickedUp = 'picked_up';
  static const String orderOnTheWay = 'on_the_way';
  static const String orderDelivered = 'delivered';
  static const String orderCancelled = 'cancelled';
  
  // Payment Methods
  static const String cashOnDelivery = 'cod';
  static const String creditCard = 'credit_card';
  static const String debitCard = 'debit_card';
  static const String digitalWallet = 'digital_wallet';
  
  // Food Categories
  static const List<String> foodCategories = [
    'Fast Food',
    'Chinese',
    'Pizza',
    'Desserts',
    'Burgers',
    'Drinks',
    'Asian',
    'Italian',
    'Mexican',
    'Indian',
    'Thai',
    'Japanese',
    'Korean',
    'Mediterranean',
    'Healthy',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Beverages',
  ];
  
  // Delivery Status
  static const String deliveryPending = 'pending';
  static const String deliveryAccepted = 'accepted';
  static const String deliveryPickedUp = 'picked_up';
  static const String deliveryOnTheWay = 'on_the_way';
  static const String deliveryDelivered = 'delivered';
  
  // Notification Types
  static const String orderNotification = 'order';
  static const String deliveryNotification = 'delivery';
  static const String promotionNotification = 'promotion';
  static const String systemNotification = 'system';
  
  // Image Constants
  static const String defaultProfileImage = 'assets/images/default_profile.png';
  static const String defaultRestaurantImage = 'assets/images/default_restaurant.png';
  static const String defaultDishImage = 'assets/images/default_dish.png';
  
  // Map Constants
  static const double defaultLatitude = 37.7749;
  static const double defaultLongitude = -122.4194;
  static const double defaultZoom = 15.0;
  
  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Keys
  static const String userCacheKey = 'user_data';
  static const String cartCacheKey = 'cart_data';
  static const String locationCacheKey = 'location_data';
  static const String preferencesCacheKey = 'user_preferences';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Error Messages
  static const String networkError = 'Network connection error';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String authError = 'Authentication failed';
  static const String permissionError = 'Permission denied';
  
  // Success Messages
  static const String orderPlacedSuccess = 'Order placed successfully';
  static const String orderCancelledSuccess = 'Order cancelled successfully';
  static const String profileUpdatedSuccess = 'Profile updated successfully';
  static const String passwordChangedSuccess = 'Password changed successfully';
  
  // Default Values
  static const double defaultDeliveryFee = 2.99;
  static const double defaultServiceFee = 0.99;
  static const double defaultTaxRate = 0.08;
  static const int defaultDeliveryTime = 30; // minutes
  static const double defaultRating = 0.0;
  static const int defaultReviewCount = 0;
}
