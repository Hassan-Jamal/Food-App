import 'dish_model.dart';

class CartItemModel {
  final String id;
  final String dishId;
  final DishModel dish;
  final int quantity;
  final String? selectedSize;
  final List<String> selectedAddOns;
  final String? specialInstructions;
  final double unitPrice;
  final double totalPrice;

  CartItemModel({
    required this.id,
    required this.dishId,
    required this.dish,
    required this.quantity,
    this.selectedSize,
    this.selectedAddOns = const [],
    this.specialInstructions,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      dishId: map['dishId'] ?? '',
      dish: DishModel.fromMap(map['dish'] ?? {}),
      quantity: map['quantity'] ?? 1,
      selectedSize: map['selectedSize'],
      selectedAddOns: List<String>.from(map['selectedAddOns'] ?? []),
      specialInstructions: map['specialInstructions'],
      unitPrice: (map['unitPrice'] ?? 0.0).toDouble(),
      totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dishId': dishId,
      'dish': dish.toMap(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedAddOns': selectedAddOns,
      'specialInstructions': specialInstructions,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? dishId,
    DishModel? dish,
    int? quantity,
    String? selectedSize,
    List<String>? selectedAddOns,
    String? specialInstructions,
    double? unitPrice,
    double? totalPrice,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      dishId: dishId ?? this.dishId,
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  String get formattedUnitPrice => '\$${unitPrice.toStringAsFixed(2)}';
  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  String get sizeDisplayText {
    if (selectedSize == null) return 'Regular';
    return selectedSize!;
  }

  String get addOnsDisplayText {
    if (selectedAddOns.isEmpty) return '';
    return selectedAddOns.join(', ');
  }

  String get fullDescription {
    final parts = <String>[];
    parts.add(dish.name);
    if (selectedSize != null) parts.add('($selectedSize)');
    if (selectedAddOns.isNotEmpty) parts.add('+ ${selectedAddOns.join(', ')}');
    return parts.join(' ');
  }
}
