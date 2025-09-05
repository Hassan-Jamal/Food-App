import 'package:flutter/foundation.dart';
import '../../shared/models/restaurant_model.dart';
import '../../shared/models/dish_model.dart';
import '../services/firebase_service.dart';
import '../constants/app_constants.dart';

class RestaurantProvider with ChangeNotifier {
  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> _filteredRestaurants = [];
  List<DishModel> _dishes = [];
  List<DishModel> _filteredDishes = [];
  RestaurantModel? _selectedRestaurant;
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<RestaurantModel> get restaurants => _restaurants;
  List<RestaurantModel> get filteredRestaurants => _filteredRestaurants;
  List<DishModel> get dishes => _dishes;
  List<DishModel> get filteredDishes => _filteredDishes;
  RestaurantModel? get selectedRestaurant => _selectedRestaurant;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  // Get restaurants by category
  List<RestaurantModel> get restaurantsByCategory {
    if (_selectedCategory == 'All') {
      return _filteredRestaurants;
    }
    return _filteredRestaurants
        .where((restaurant) => restaurant.categories.contains(_selectedCategory))
        .toList();
  }

  // Get available categories
  List<String> get availableCategories {
    final categories = <String>{'All'};
    for (final restaurant in _restaurants) {
      categories.addAll(restaurant.categories);
    }
    return categories.toList()..sort();
  }

  Future<void> loadRestaurants() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final snapshot = await FirebaseService.getCollectionWithQuery(
        AppConstants.restaurantsCollection,
        (query) => query.where('isActive', isEqualTo: true),
      );

      _restaurants = snapshot.docs
          .map((doc) => RestaurantModel.fromMap(doc.data()))
          .toList();

      _applyFilters();
    } catch (e) {
      _errorMessage = 'Failed to load restaurants: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String restaurantId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final doc = await FirebaseService.getDocument(
        '${AppConstants.restaurantsCollection}/$restaurantId',
      );

      if (doc.exists) {
        _selectedRestaurant = RestaurantModel.fromMap(doc.data()!);
      } else {
        _errorMessage = 'Restaurant not found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load restaurant: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDishesByRestaurant(String restaurantId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final snapshot = await FirebaseService.getCollectionWithQuery(
        AppConstants.dishesCollection,
        (query) => query
            .where('restaurantId', isEqualTo: restaurantId)
            .where('isAvailable', isEqualTo: true),
      );

      _dishes = snapshot.docs
          .map((doc) => DishModel.fromMap(doc.data()))
          .toList();

      _applyDishFilters();
    } catch (e) {
      _errorMessage = 'Failed to load dishes: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    _searchQuery = query;
    _applyFilters();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredRestaurants = _restaurants.where((restaurant) {
      final matchesSearch = _searchQuery.isEmpty ||
          restaurant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          restaurant.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' ||
          restaurant.categories.contains(_selectedCategory);

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  void _applyDishFilters() {
    _filteredDishes = _dishes.where((dish) {
      final matchesSearch = _searchQuery.isEmpty ||
          dish.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dish.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' ||
          dish.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  Future<bool> createRestaurant(RestaurantModel restaurant) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.setDocument(
        '${AppConstants.restaurantsCollection}/${restaurant.id}',
        restaurant.toMap(),
      );

      _restaurants.add(restaurant);
      _applyFilters();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create restaurant: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateRestaurant(RestaurantModel restaurant) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.restaurantsCollection}/${restaurant.id}',
        restaurant.toMap(),
      );

      final index = _restaurants.indexWhere((r) => r.id == restaurant.id);
      if (index != -1) {
        _restaurants[index] = restaurant;
        _applyFilters();
      }

      if (_selectedRestaurant?.id == restaurant.id) {
        _selectedRestaurant = restaurant;
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to update restaurant: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteRestaurant(String restaurantId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.deleteDocument(
        '${AppConstants.restaurantsCollection}/$restaurantId',
      );

      _restaurants.removeWhere((r) => r.id == restaurantId);
      _applyFilters();

      if (_selectedRestaurant?.id == restaurantId) {
        _selectedRestaurant = null;
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete restaurant: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createDish(DishModel dish) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.setDocument(
        '${AppConstants.dishesCollection}/${dish.id}',
        dish.toMap(),
      );

      _dishes.add(dish);
      _applyDishFilters();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create dish: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateDish(DishModel dish) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.updateDocument(
        '${AppConstants.dishesCollection}/${dish.id}',
        dish.toMap(),
      );

      final index = _dishes.indexWhere((d) => d.id == dish.id);
      if (index != -1) {
        _dishes[index] = dish;
        _applyDishFilters();
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to update dish: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteDish(String dishId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.deleteDocument(
        '${AppConstants.dishesCollection}/$dishId',
      );

      _dishes.removeWhere((d) => d.id == dishId);
      _applyDishFilters();

      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete dish: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearFilters() {
    _selectedCategory = 'All';
    _searchQuery = '';
    _applyFilters();
  }
}
