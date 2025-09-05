import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/providers/restaurant_provider.dart';
import '../../../../core/providers/cart_provider.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    await restaurantProvider.loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Search Bar
            _buildSearchBar(),
            
            // Categories
            _buildCategories(),
            
            // Restaurants List
            Expanded(
              child: _buildRestaurantsList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver to',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primaryPink,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '123 Main Street, City',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Profile Avatar
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.profile),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchBarWidget(
        onSearchChanged: (query) {
          final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
          restaurantProvider.searchRestaurants(query);
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: restaurantProvider.availableCategories.length,
            itemBuilder: (context, index) {
              final category = restaurantProvider.availableCategories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CategoryChip(
                  label: category,
                  isSelected: restaurantProvider.selectedCategory == category,
                  onTap: () {
                    restaurantProvider.setCategory(category);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRestaurantsList() {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        if (restaurantProvider.isLoading) {
          return const Center(
            child: LoadingWidget(message: 'Loading restaurants...'),
          );
        }

        if (restaurantProvider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.textLight,
                ),
                const SizedBox(height: 16),
                Text(
                  restaurantProvider.errorMessage!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _loadData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final restaurants = restaurantProvider.restaurantsByCategory;

        if (restaurants.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_outlined,
                  size: 64,
                  color: AppColors.textLight,
                ),
                const SizedBox(height: 16),
                Text(
                  'No restaurants found',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.restaurantDetail,
                    arguments: restaurant.id,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            // Home - already here
            break;
          case 1:
            Get.toNamed(AppRoutes.orderHistory);
            break;
          case 2:
            Get.toNamed(AppRoutes.cart);
            break;
          case 3:
            Get.toNamed(AppRoutes.profile);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        if (cartProvider.isEmpty) return const SizedBox.shrink();

        return FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.cart),
          backgroundColor: AppColors.primaryPink,
          child: Stack(
            children: [
              const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.errorRed,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
