import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final String address;
  final Map<String, dynamic> location; // {lat: double, lng: double}
  final String phone;
  final String email;
  final List<String> categories;
  final double rating;
  final int reviewCount;
  final int deliveryTime; // in minutes
  final double deliveryFee;
  final double minimumOrder;
  final bool isActive;
  final bool isApproved;
  final String ownerId;
  final List<String> imageUrls;
  final Map<String, String> operatingHours; // {day: "open-close"}
  final DateTime createdAt;
  final DateTime updatedAt;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.address,
    required this.location,
    required this.phone,
    required this.email,
    required this.categories,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.deliveryTime = 30,
    this.deliveryFee = 2.99,
    this.minimumOrder = 10.0,
    this.isActive = true,
    this.isApproved = false,
    required this.ownerId,
    this.imageUrls = const [],
    this.operatingHours = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      address: map['address'] ?? '',
      location: Map<String, dynamic>.from(map['location'] ?? {}),
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      deliveryTime: map['deliveryTime'] ?? 30,
      deliveryFee: (map['deliveryFee'] ?? 2.99).toDouble(),
      minimumOrder: (map['minimumOrder'] ?? 10.0).toDouble(),
      isActive: map['isActive'] ?? true,
      isApproved: map['isApproved'] ?? false,
      ownerId: map['ownerId'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      operatingHours: Map<String, String>.from(map['operatingHours'] ?? {}),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logoUrl': logoUrl,
      'address': address,
      'location': location,
      'phone': phone,
      'email': email,
      'categories': categories,
      'rating': rating,
      'reviewCount': reviewCount,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'minimumOrder': minimumOrder,
      'isActive': isActive,
      'isApproved': isApproved,
      'ownerId': ownerId,
      'imageUrls': imageUrls,
      'operatingHours': operatingHours,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? description,
    String? logoUrl,
    String? address,
    Map<String, dynamic>? location,
    String? phone,
    String? email,
    List<String>? categories,
    double? rating,
    int? reviewCount,
    int? deliveryTime,
    double? deliveryFee,
    double? minimumOrder,
    bool? isActive,
    bool? isApproved,
    String? ownerId,
    List<String>? imageUrls,
    Map<String, String>? operatingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      address: address ?? this.address,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      isActive: isActive ?? this.isActive,
      isApproved: isApproved ?? this.isApproved,
      ownerId: ownerId ?? this.ownerId,
      imageUrls: imageUrls ?? this.imageUrls,
      operatingHours: operatingHours ?? this.operatingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get latitude => location['lat']?.toDouble() ?? 0.0;
  double get longitude => location['lng']?.toDouble() ?? 0.0;
  
  bool get isOpen {
    final now = DateTime.now();
    final dayName = _getDayName(now.weekday);
    final hours = operatingHours[dayName];
    
    if (hours == null || hours.isEmpty) return false;
    
    final parts = hours.split('-');
    if (parts.length != 2) return false;
    
    final openTime = _parseTime(parts[0]);
    final closeTime = _parseTime(parts[1]);
    final currentTime = now.hour + (now.minute / 60.0);
    
    return currentTime >= openTime && currentTime <= closeTime;
  }

  String _getDayName(int weekday) {
    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    return days[weekday - 1];
  }

  double _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return hour + (minute / 60.0);
  }
}
