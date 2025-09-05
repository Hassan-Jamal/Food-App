import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String role; // customer, restaurant, rider, admin
  final String? profileImageUrl;
  final String? address;
  final Map<String, dynamic>? location; // {lat: double, lng: double}
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Restaurant specific fields
  final String? restaurantId;
  final String? restaurantName;
  final String? restaurantDescription;
  final String? restaurantLogoUrl;
  final String? restaurantAddress;
  final Map<String, dynamic>? restaurantLocation;
  final double? restaurantRating;
  final int? restaurantReviewCount;
  final bool? isRestaurantApproved;
  
  // Rider specific fields
  final String? vehicleType;
  final String? vehicleNumber;
  final String? licenseNumber;
  final bool? isRiderAvailable;
  final double? currentLatitude;
  final double? currentLongitude;
  final double? riderRating;
  final int? riderReviewCount;
  final int? completedDeliveries;
  
  // Admin specific fields
  final bool? isSuperAdmin;
  final List<String>? permissions;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    this.profileImageUrl,
    this.address,
    this.location,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.restaurantId,
    this.restaurantName,
    this.restaurantDescription,
    this.restaurantLogoUrl,
    this.restaurantAddress,
    this.restaurantLocation,
    this.restaurantRating,
    this.restaurantReviewCount,
    this.isRestaurantApproved,
    this.vehicleType,
    this.vehicleNumber,
    this.licenseNumber,
    this.isRiderAvailable,
    this.currentLatitude,
    this.currentLongitude,
    this.riderRating,
    this.riderReviewCount,
    this.completedDeliveries,
    this.isSuperAdmin,
    this.permissions,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'customer',
      profileImageUrl: map['profileImageUrl'],
      address: map['address'],
      location: map['location'] != null ? Map<String, dynamic>.from(map['location']) : null,
      isActive: map['isActive'] ?? true,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      restaurantId: map['restaurantId'],
      restaurantName: map['restaurantName'],
      restaurantDescription: map['restaurantDescription'],
      restaurantLogoUrl: map['restaurantLogoUrl'],
      restaurantAddress: map['restaurantAddress'],
      restaurantLocation: map['restaurantLocation'] != null ? Map<String, dynamic>.from(map['restaurantLocation']) : null,
      restaurantRating: map['restaurantRating']?.toDouble(),
      restaurantReviewCount: map['restaurantReviewCount'],
      isRestaurantApproved: map['isRestaurantApproved'],
      vehicleType: map['vehicleType'],
      vehicleNumber: map['vehicleNumber'],
      licenseNumber: map['licenseNumber'],
      isRiderAvailable: map['isRiderAvailable'],
      currentLatitude: map['currentLatitude']?.toDouble(),
      currentLongitude: map['currentLongitude']?.toDouble(),
      riderRating: map['riderRating']?.toDouble(),
      riderReviewCount: map['riderReviewCount'],
      completedDeliveries: map['completedDeliveries'],
      isSuperAdmin: map['isSuperAdmin'],
      permissions: map['permissions'] != null ? List<String>.from(map['permissions']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'location': location,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantDescription': restaurantDescription,
      'restaurantLogoUrl': restaurantLogoUrl,
      'restaurantAddress': restaurantAddress,
      'restaurantLocation': restaurantLocation,
      'restaurantRating': restaurantRating,
      'restaurantReviewCount': restaurantReviewCount,
      'isRestaurantApproved': isRestaurantApproved,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'licenseNumber': licenseNumber,
      'isRiderAvailable': isRiderAvailable,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
      'riderRating': riderRating,
      'riderReviewCount': riderReviewCount,
      'completedDeliveries': completedDeliveries,
      'isSuperAdmin': isSuperAdmin,
      'permissions': permissions,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? role,
    String? profileImageUrl,
    String? address,
    Map<String, dynamic>? location,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? restaurantId,
    String? restaurantName,
    String? restaurantDescription,
    String? restaurantLogoUrl,
    String? restaurantAddress,
    Map<String, dynamic>? restaurantLocation,
    double? restaurantRating,
    int? restaurantReviewCount,
    bool? isRestaurantApproved,
    String? vehicleType,
    String? vehicleNumber,
    String? licenseNumber,
    bool? isRiderAvailable,
    double? currentLatitude,
    double? currentLongitude,
    double? riderRating,
    int? riderReviewCount,
    int? completedDeliveries,
    bool? isSuperAdmin,
    List<String>? permissions,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      address: address ?? this.address,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantDescription: restaurantDescription ?? this.restaurantDescription,
      restaurantLogoUrl: restaurantLogoUrl ?? this.restaurantLogoUrl,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      restaurantLocation: restaurantLocation ?? this.restaurantLocation,
      restaurantRating: restaurantRating ?? this.restaurantRating,
      restaurantReviewCount: restaurantReviewCount ?? this.restaurantReviewCount,
      isRestaurantApproved: isRestaurantApproved ?? this.isRestaurantApproved,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      isRiderAvailable: isRiderAvailable ?? this.isRiderAvailable,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      riderRating: riderRating ?? this.riderRating,
      riderReviewCount: riderReviewCount ?? this.riderReviewCount,
      completedDeliveries: completedDeliveries ?? this.completedDeliveries,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      permissions: permissions ?? this.permissions,
    );
  }

  bool get isCustomer => role == 'customer';
  bool get isRestaurant => role == 'restaurant';
  bool get isRider => role == 'rider';
  bool get isAdmin => role == 'admin';
}
