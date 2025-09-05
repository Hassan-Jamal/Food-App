import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 180,
                width: double.infinity,
                color: AppColors.backgroundWhite,
                child: restaurant.logoUrl.isNotEmpty
                    ? Image.network(
                        restaurant.logoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage();
                        },
                      )
                    : _buildPlaceholderImage(),
              ),
            ),
            
            // Restaurant Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Name and Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Categories
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: restaurant.categories.take(3).map((category) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPinkLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryPink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Delivery Info
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textMedium,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurant.deliveryTime} min',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: AppColors.textMedium,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.formattedDeliveryFee,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                      const Spacer(),
                      if (restaurant.isOpen)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Open',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.accentGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.textLight.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Closed',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.backgroundWhite,
      child: const Center(
        child: Icon(
          Icons.restaurant,
          size: 64,
          color: AppColors.textLight,
        ),
      ),
    );
  }
}

extension RestaurantModelExtension on RestaurantModel {
  String get formattedDeliveryFee => '\$${deliveryFee.toStringAsFixed(2)}';
}
