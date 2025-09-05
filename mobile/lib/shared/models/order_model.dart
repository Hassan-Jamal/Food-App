import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final Map<String, dynamic> customerLocation;
  final String restaurantId;
  final String restaurantName;
  final String restaurantAddress;
  final Map<String, dynamic> restaurantLocation;
  final String? riderId;
  final String? riderName;
  final String? riderPhone;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double tax;
  final double total;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String deliveryStatus;
  final String? specialInstructions;
  final DateTime estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? trackingData;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerLocation,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantLocation,
    this.riderId,
    this.riderName,
    this.riderPhone,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.tax,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.deliveryStatus,
    this.specialInstructions,
    required this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
    this.trackingData,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      customerAddress: map['customerAddress'] ?? '',
      customerLocation: Map<String, dynamic>.from(map['customerLocation'] ?? {}),
      restaurantId: map['restaurantId'] ?? '',
      restaurantName: map['restaurantName'] ?? '',
      restaurantAddress: map['restaurantAddress'] ?? '',
      restaurantLocation: Map<String, dynamic>.from(map['restaurantLocation'] ?? {}),
      riderId: map['riderId'],
      riderName: map['riderName'],
      riderPhone: map['riderPhone'],
      items: (map['items'] as List<dynamic>?)
          ?.map((item) => CartItemModel.fromMap(item))
          .toList() ?? [],
      subtotal: (map['subtotal'] ?? 0.0).toDouble(),
      deliveryFee: (map['deliveryFee'] ?? 0.0).toDouble(),
      serviceFee: (map['serviceFee'] ?? 0.0).toDouble(),
      tax: (map['tax'] ?? 0.0).toDouble(),
      total: (map['total'] ?? 0.0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? 'cod',
      paymentStatus: map['paymentStatus'] ?? 'pending',
      orderStatus: map['orderStatus'] ?? 'placed',
      deliveryStatus: map['deliveryStatus'] ?? 'pending',
      specialInstructions: map['specialInstructions'],
      estimatedDeliveryTime: (map['estimatedDeliveryTime'] as Timestamp).toDate(),
      actualDeliveryTime: map['actualDeliveryTime'] != null 
          ? (map['actualDeliveryTime'] as Timestamp).toDate() 
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      trackingData: map['trackingData'] != null 
          ? Map<String, dynamic>.from(map['trackingData']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'customerLocation': customerLocation,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'restaurantLocation': restaurantLocation,
      'riderId': riderId,
      'riderName': riderName,
      'riderPhone': riderPhone,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'tax': tax,
      'total': total,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'deliveryStatus': deliveryStatus,
      'specialInstructions': specialInstructions,
      'estimatedDeliveryTime': Timestamp.fromDate(estimatedDeliveryTime),
      'actualDeliveryTime': actualDeliveryTime != null 
          ? Timestamp.fromDate(actualDeliveryTime!) 
          : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'trackingData': trackingData,
    };
  }

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    Map<String, dynamic>? customerLocation,
    String? restaurantId,
    String? restaurantName,
    String? restaurantAddress,
    Map<String, dynamic>? restaurantLocation,
    String? riderId,
    String? riderName,
    String? riderPhone,
    List<CartItemModel>? items,
    double? subtotal,
    double? deliveryFee,
    double? serviceFee,
    double? tax,
    double? total,
    String? paymentMethod,
    String? paymentStatus,
    String? orderStatus,
    String? deliveryStatus,
    String? specialInstructions,
    DateTime? estimatedDeliveryTime,
    DateTime? actualDeliveryTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? trackingData,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      customerLocation: customerLocation ?? this.customerLocation,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      restaurantLocation: restaurantLocation ?? this.restaurantLocation,
      riderId: riderId ?? this.riderId,
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      actualDeliveryTime: actualDeliveryTime ?? this.actualDeliveryTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      trackingData: trackingData ?? this.trackingData,
    );
  }

  double get customerLatitude => customerLocation['lat']?.toDouble() ?? 0.0;
  double get customerLongitude => customerLocation['lng']?.toDouble() ?? 0.0;
  double get restaurantLatitude => restaurantLocation['lat']?.toDouble() ?? 0.0;
  double get restaurantLongitude => restaurantLocation['lng']?.toDouble() ?? 0.0;

  bool get isPlaced => orderStatus == 'placed';
  bool get isAccepted => orderStatus == 'accepted';
  bool get isPreparing => orderStatus == 'preparing';
  bool get isReady => orderStatus == 'ready';
  bool get isPickedUp => deliveryStatus == 'picked_up';
  bool get isOnTheWay => deliveryStatus == 'on_the_way';
  bool get isDelivered => deliveryStatus == 'delivered';
  bool get isCancelled => orderStatus == 'cancelled';

  String get statusDisplayText {
    if (isCancelled) return 'Cancelled';
    if (isDelivered) return 'Delivered';
    if (isOnTheWay) return 'On the way';
    if (isPickedUp) return 'Picked up';
    if (isReady) return 'Ready for pickup';
    if (isPreparing) return 'Preparing';
    if (isAccepted) return 'Accepted';
    return 'Placed';
  }

  String get formattedTotal => '\$${total.toStringAsFixed(2)}';
  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
  String get formattedDeliveryFee => '\$${deliveryFee.toStringAsFixed(2)}';
  String get formattedServiceFee => '\$${serviceFee.toStringAsFixed(2)}';
  String get formattedTax => '\$${tax.toStringAsFixed(2)}';

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}
