import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class RoleSelector extends StatelessWidget {
  final String selectedRole;
  final Function(String) onRoleChanged;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final roles = [
      {
        'value': 'customer',
        'label': 'Customer',
        'icon': Icons.person,
        'description': 'Order food',
      },
      {
        'value': 'restaurant',
        'label': 'Restaurant',
        'icon': Icons.restaurant,
        'description': 'Manage orders',
      },
      {
        'value': 'rider',
        'label': 'Rider',
        'icon': Icons.delivery_dining,
        'description': 'Deliver orders',
      },
      {
        'value': 'admin',
        'label': 'Admin',
        'icon': Icons.admin_panel_settings,
        'description': 'Manage system',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Role',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: roles.map((role) {
            final isSelected = selectedRole == role['value'];
            return GestureDetector(
              onTap: () => onRoleChanged(role['value'] as String),
              child: Container(
                width: (MediaQuery.of(context).size.width - 72) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryPink : AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primaryPink 
                        : AppColors.textLight.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primaryPink.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      role['icon'] as IconData,
                      size: 32,
                      color: isSelected ? Colors.white : AppColors.primaryPink,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      role['label'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role['description'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected 
                            ? Colors.white.withOpacity(0.8)
                            : AppColors.textMedium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
