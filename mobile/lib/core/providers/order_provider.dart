import 'package:flutter/foundation.dart';
import '../../shared/models/order_model.dart';
import '../../shared/models/cart_item_model.dart';
import '../services/firebase_service.dart';
import '../constants/app_constants.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> _filteredOrders = [];
  OrderModel? _selectedOrder;
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedStatus = 'All';
  String _searchQuery = '';

  List<OrderModel> get orders => _orders;
  List<OrderModel> get filteredOrders => _filteredOrders;
  OrderModel? get selectedOrder => _selectedOrder;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedStatus => _selectedStatus;
  String get searchQuery => _searchQuery;

  // Get orders by status
  List<OrderModel> get ordersByStatus {
    if (_selectedStatus == 'All') {
      return _filteredOrders;
    }
    return _filteredOrders
        .where((order) => order.orderStatus == _selectedStatus)
        .toList();
  }

  // Get available statuses
  List<String> get availableStatuses => [
    'All',
    AppConstants.orderPlaced,
    AppConstants.orderAccepted,
    AppConstants.orderPreparing,
    AppConstants.orderReady,
    AppConstants.orderPickedUp,
    AppConstants.orderOnTheWay,
    AppConstants.orderDelivered,
    AppConstants.orderCancelled,
  ];

  Future<void> loadOrders({String? userId, String? role}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      Query query = FirebaseService.firestore.collection(AppConstants.ordersCollection);

      // Filter by user role
      if (role == AppConstants.customerRole && userId != null) {
        query = query.where('customerId', isEqualTo: userId);
      } else if (role == AppConstants.restaurantRole && userId != null) {
        query = query.where('restaurantId', isEqualTo: userId);
      } else if (role == AppConstants.riderRole && userId != null) {
        query = query.where('riderId', isEqualTo: userId);
      }

      // Order by creation date (newest first)
      query = query.orderBy('createdAt', descending: true);

      final snapshot = await query.get();

      _orders = snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _applyFilters();
    } catch (e) {
      _errorMessage = 'Failed to load orders: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOrderById(String orderId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final doc = await FirebaseService.getDocument(
        '${AppConstants.ordersCollection}/$orderId',
      );

      if (doc.exists) {
        _selectedOrder = OrderModel.fromMap(doc.data()!);
      } else {
        _errorMessage = 'Order not found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load order: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOrder({
    required String customerId,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required Map<String, dynamic> customerLocation,
    required String restaurantId,
    required String restaurantName,
    required String restaurantAddress,
    required Map<String, dynamic> restaurantLocation,
    required List<CartItemModel> items,
    required double subtotal,
    required double deliveryFee,
    required double serviceFee,
    required double tax,
    required double total,
    required String paymentMethod,
    String? specialInstructions,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      final now = DateTime.now();
      final estimatedDeliveryTime = now.add(const Duration(minutes: 30));

      final order = OrderModel(
        id: orderId,
        customerId: customerId,
        customerName: customerName,
        customerPhone: customerPhone,
        customerAddress: customerAddress,
        customerLocation: customerLocation,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        restaurantAddress: restaurantAddress,
        restaurantLocation: restaurantLocation,
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        serviceFee: serviceFee,
        tax: tax,
        total: total,
        paymentMethod: paymentMethod,
        paymentStatus: paymentMethod == AppConstants.cashOnDelivery ? 'pending' : 'paid',
        orderStatus: AppConstants.orderPlaced,
        deliveryStatus: AppConstants.deliveryPending,
        specialInstructions: specialInstructions,
        estimatedDeliveryTime: estimatedDeliveryTime,
        createdAt: now,
        updatedAt: now,
      );

      await FirebaseService.setDocument(
        '${AppConstants.ordersCollection}/$orderId',
        order.toMap(),
      );

      _orders.insert(0, order);
      _applyFilters();

      // Send real-time notification
      await _sendOrderNotification(order);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to create order: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.ordersCollection}/$orderId',
        {
          'orderStatus': status,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          orderStatus: status,
          updatedAt: DateTime.now(),
        );
        _applyFilters();
      }

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = _selectedOrder!.copyWith(
          orderStatus: status,
          updatedAt: DateTime.now(),
        );
      }

      // Send real-time notification
      await _sendStatusUpdateNotification(orderId, status);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to update order status: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateDeliveryStatus(String orderId, String status) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.ordersCollection}/$orderId',
        {
          'deliveryStatus': status,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          deliveryStatus: status,
          updatedAt: DateTime.now(),
        );
        _applyFilters();
      }

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = _selectedOrder!.copyWith(
          deliveryStatus: status,
          updatedAt: DateTime.now(),
        );
      }

      // Send real-time notification
      await _sendDeliveryUpdateNotification(orderId, status);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to update delivery status: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> assignRider(String orderId, String riderId, String riderName, String riderPhone) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.ordersCollection}/$orderId',
        {
          'riderId': riderId,
          'riderName': riderName,
          'riderPhone': riderPhone,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          riderId: riderId,
          riderName: riderName,
          riderPhone: riderPhone,
          updatedAt: DateTime.now(),
        );
        _applyFilters();
      }

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = _selectedOrder!.copyWith(
          riderId: riderId,
          riderName: riderName,
          riderPhone: riderPhone,
          updatedAt: DateTime.now(),
        );
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to assign rider: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.ordersCollection}/$orderId',
        {
          'orderStatus': AppConstants.orderCancelled,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          orderStatus: AppConstants.orderCancelled,
          updatedAt: DateTime.now(),
        );
        _applyFilters();
      }

      if (_selectedOrder?.id == orderId) {
        _selectedOrder = _selectedOrder!.copyWith(
          orderStatus: AppConstants.orderCancelled,
          updatedAt: DateTime.now(),
        );
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to cancel order: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchOrders(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setStatus(String status) {
    _selectedStatus = status;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredOrders = _orders.where((order) {
      final matchesSearch = _searchQuery.isEmpty ||
          order.id.contains(_searchQuery) ||
          order.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          order.restaurantName.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus = _selectedStatus == 'All' ||
          order.orderStatus == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    notifyListeners();
  }

  Future<void> _sendOrderNotification(OrderModel order) async {
    try {
      // Send notification to restaurant
      await FirebaseService.setRealtimeData(
        'notifications/restaurants/${order.restaurantId}/${DateTime.now().millisecondsSinceEpoch}',
        {
          'type': 'new_order',
          'orderId': order.id,
          'customerName': order.customerName,
          'total': order.total,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      // Handle notification error silently
    }
  }

  Future<void> _sendStatusUpdateNotification(String orderId, String status) async {
    try {
      final order = _orders.firstWhere((o) => o.id == orderId);
      
      // Send notification to customer
      await FirebaseService.setRealtimeData(
        'notifications/customers/${order.customerId}/${DateTime.now().millisecondsSinceEpoch}',
        {
          'type': 'order_status_update',
          'orderId': orderId,
          'status': status,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      // Handle notification error silently
    }
  }

  Future<void> _sendDeliveryUpdateNotification(String orderId, String status) async {
    try {
      final order = _orders.firstWhere((o) => o.id == orderId);
      
      // Send notification to customer
      await FirebaseService.setRealtimeData(
        'notifications/customers/${order.customerId}/${DateTime.now().millisecondsSinceEpoch}',
        {
          'type': 'delivery_status_update',
          'orderId': orderId,
          'status': status,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      // Handle notification error silently
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearFilters() {
    _selectedStatus = 'All';
    _searchQuery = '';
    _applyFilters();
  }
}
