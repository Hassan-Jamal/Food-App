import 'package:cloud_firestore/cloud_firestore.dart';

class DishModel {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> ingredients;
  final List<String> allergens;
  final int preparationTime; // in minutes
  final bool isAvailable;
  final bool isVegetarian;
  final bool isVegan;
  final bool isSpicy;
  final double rating;
  final int reviewCount;
  final int orderCount;
  final Map<String, double>? sizeOptions; // {size: price}
  final List<Map<String, dynamic>>? addOns; // [{name: string, price: double}]
  final DateTime createdAt;
  final DateTime updatedAt;

  DishModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.ingredients = const [],
    this.allergens = const [],
    this.preparationTime = 15,
    this.isAvailable = true,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isSpicy = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.orderCount = 0,
    this.sizeOptions,
    this.addOns,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      id: map['id'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      allergens: List<String>.from(map['allergens'] ?? []),
      preparationTime: map['preparationTime'] ?? 15,
      isAvailable: map['isAvailable'] ?? true,
      isVegetarian: map['isVegetarian'] ?? false,
      isVegan: map['isVegan'] ?? false,
      isSpicy: map['isSpicy'] ?? false,
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      orderCount: map['orderCount'] ?? 0,
      sizeOptions: map['sizeOptions'] != null 
          ? Map<String, double>.from(map['sizeOptions']) 
          : null,
      addOns: map['addOns'] != null 
          ? List<Map<String, dynamic>>.from(map['addOns']) 
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'ingredients': ingredients,
      'allergens': allergens,
      'preparationTime': preparationTime,
      'isAvailable': isAvailable,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isSpicy': isSpicy,
      'rating': rating,
      'reviewCount': reviewCount,
      'orderCount': orderCount,
      'sizeOptions': sizeOptions,
      'addOns': addOns,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  DishModel copyWith({
    String? id,
    String? restaurantId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    List<String>? ingredients,
    List<String>? allergens,
    int? preparationTime,
    bool? isAvailable,
    bool? isVegetarian,
    bool? isVegan,
    bool? isSpicy,
    double? rating,
    int? reviewCount,
    int? orderCount,
    Map<String, double>? sizeOptions,
    List<Map<String, dynamic>>? addOns,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DishModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      preparationTime: preparationTime ?? this.preparationTime,
      isAvailable: isAvailable ?? this.isAvailable,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isSpicy: isSpicy ?? this.isSpicy,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      orderCount: orderCount ?? this.orderCount,
      sizeOptions: sizeOptions ?? this.sizeOptions,
      addOns: addOns ?? this.addOns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double getPriceForSize(String? size) {
    if (size == null || sizeOptions == null) return price;
    return sizeOptions![size] ?? price;
  }

  List<String> get availableSizes {
    if (sizeOptions == null) return ['Regular'];
    return sizeOptions!.keys.toList();
  }

  List<Map<String, dynamic>> get availableAddOns {
    return addOns ?? [];
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  
  String get dietaryInfo {
    final info = <String>[];
    if (isVegetarian) info.add('Vegetarian');
    if (isVegan) info.add('Vegan');
    if (isSpicy) info.add('Spicy');
    return info.join(' • ');
  }
}
