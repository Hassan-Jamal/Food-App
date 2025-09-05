import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  CartItem({required this.menuItemId, required this.name, required this.price, required this.quantity});
  final String menuItemId;
  final String name;
  final num price;
  final int quantity;

  CartItem copyWith({int? quantity}) => CartItem(menuItemId: menuItemId, name: name, price: price, quantity: quantity ?? this.quantity);
}

class CartState {
  CartState(this.items);
  final List<CartItem> items;
  num get total => items.fold<num>(0, (num sum, CartItem i) => sum + i.price * i.quantity);
}

class CartController extends StateNotifier<CartState> {
  CartController() : super(CartState(<CartItem>[]));

  void addItem(CartItem item) {
    final int index = state.items.indexWhere((CartItem i) => i.menuItemId == item.menuItemId);
    if (index == -1) {
      state = CartState(<CartItem>[...state.items, item]);
    } else {
      final List<CartItem> updated = List<CartItem>.from(state.items);
      final CartItem existing = updated[index];
      updated[index] = existing.copyWith(quantity: existing.quantity + item.quantity);
      state = CartState(updated);
    }
  }

  void removeItem(String menuItemId) {
    state = CartState(state.items.where((CartItem i) => i.menuItemId != menuItemId).toList());
  }

  void clear() => state = CartState(<CartItem>[]);
}

final cartProvider = StateNotifierProvider<CartController, CartState>((ref) {
  return CartController();
});

