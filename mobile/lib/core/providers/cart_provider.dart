import 'package:flutter/foundation.dart';
import '../../shared/models/cart_item_model.dart';
import '../../shared/models/dish_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItemModel> _cartItems = [];
  String? _restaurantId;
  double _deliveryFee = 0.0;
  double _serviceFee = 0.0;
  double _taxRate = 0.08;

  List<CartItemModel> get cartItems => _cartItems;
  String? get restaurantId => _restaurantId;
  double get deliveryFee => _deliveryFee;
  double get serviceFee => _serviceFee;
  double get taxRate => _taxRate;
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => _cartItems.isEmpty;
  bool get isNotEmpty => _cartItems.isNotEmpty;

  double get subtotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get tax {
    return subtotal * _taxRate;
  }

  double get total {
    return subtotal + _deliveryFee + _serviceFee + tax;
  }

  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
  String get formattedDeliveryFee => '\$${_deliveryFee.toStringAsFixed(2)}';
  String get formattedServiceFee => '\$${_serviceFee.toStringAsFixed(2)}';
  String get formattedTax => '\$${tax.toStringAsFixed(2)}';
  String get formattedTotal => '\$${total.toStringAsFixed(2)}';

  void addToCart({
    required DishModel dish,
    int quantity = 1,
    String? selectedSize,
    List<String> selectedAddOns = const [],
    String? specialInstructions,
  }) {
    // Check if adding from different restaurant
    if (_restaurantId != null && _restaurantId != dish.restaurantId) {
      clearCart();
    }

    _restaurantId = dish.restaurantId;

    // Calculate unit price
    double unitPrice = dish.getPriceForSize(selectedSize);
    
    // Add add-on prices
    for (final addOnName in selectedAddOns) {
      final addOn = dish.availableAddOns.firstWhere(
        (addOn) => addOn['name'] == addOnName,
        orElse: () => {'name': addOnName, 'price': 0.0},
      );
      unitPrice += addOn['price']?.toDouble() ?? 0.0;
    }

    final totalPrice = unitPrice * quantity;

    // Check if item already exists with same configuration
    final existingIndex = _cartItems.indexWhere((item) =>
        item.dishId == dish.id &&
        item.selectedSize == selectedSize &&
        _listEquals(item.selectedAddOns, selectedAddOns) &&
        item.specialInstructions == specialInstructions);

    if (existingIndex != -1) {
      // Update existing item
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
        totalPrice: unitPrice * (existingItem.quantity + quantity),
      );
    } else {
      // Add new item
      final cartItem = CartItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dishId: dish.id,
        dish: dish,
        quantity: quantity,
        selectedSize: selectedSize,
        selectedAddOns: selectedAddOns,
        specialInstructions: specialInstructions,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
      );
      _cartItems.add(cartItem);
    }

    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final item = _cartItems[index];
      _cartItems[index] = item.copyWith(
        quantity: quantity,
        totalPrice: item.unitPrice * quantity,
      );
      notifyListeners();
    }
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    
    // Clear restaurant ID if cart is empty
    if (_cartItems.isEmpty) {
      _restaurantId = null;
    }
    
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _restaurantId = null;
    notifyListeners();
  }

  void setDeliveryFee(double fee) {
    _deliveryFee = fee;
    notifyListeners();
  }

  void setServiceFee(double fee) {
    _serviceFee = fee;
    notifyListeners();
  }

  void setTaxRate(double rate) {
    _taxRate = rate;
    notifyListeners();
  }

  bool canAddFromRestaurant(String restaurantId) {
    return _restaurantId == null || _restaurantId == restaurantId;
  }

  CartItemModel? getCartItem(String itemId) {
    try {
      return _cartItems.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  int getItemQuantity(String dishId, {String? selectedSize, List<String>? selectedAddOns}) {
    final item = _cartItems.firstWhere(
      (item) =>
          item.dishId == dishId &&
          item.selectedSize == selectedSize &&
          _listEquals(item.selectedAddOns, selectedAddOns ?? []),
      orElse: () => CartItemModel(
        id: '',
        dishId: dishId,
        dish: DishModel(
          id: dishId,
          restaurantId: '',
          name: '',
          description: '',
          price: 0.0,
          imageUrl: '',
          category: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        quantity: 0,
        unitPrice: 0.0,
        totalPrice: 0.0,
      ),
    );
    return item.quantity;
  }

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}
