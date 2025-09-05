class AppUser {
  AppUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.photoUrl,
    this.phoneNumber,
    this.address,
  });

  final String id;
  final String email;
  final String displayName;
  final String role; // customer|restaurant|rider|admin
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;
}

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.description,
    this.address,
    this.category,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String name;
  final String? logoUrl;
  final String? description;
  final String? address;
  final String? category;
  final double? latitude;
  final double? longitude;
}

class MenuItemModel {
  MenuItemModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    this.imageUrl,
    this.category,
    this.available = true,
  });

  final String id;
  final String restaurantId;
  final String name;
  final num price;
  final String? imageUrl;
  final String? category;
  final bool available;
}

class OrderItemModel {
  OrderItemModel({
    required this.menuItemId,
    required this.quantity,
    required this.price,
  });

  final String menuItemId;
  final int quantity;
  final num price;
}

class OrderModel {
  OrderModel({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    required this.items,
    required this.total,
    required this.status,
    this.riderId,
  });

  final String id;
  final String customerId;
  final String restaurantId;
  final List<OrderItemModel> items;
  final num total;
  final String status; // placed|accepted|preparing|ready|on_the_way|delivered
  final String? riderId;
}

