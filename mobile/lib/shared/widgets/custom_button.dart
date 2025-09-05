import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.padding,
    this.icon,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = !isEnabled || isLoading || onPressed == null;

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height ?? 48,
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primaryPink,
            side: BorderSide(
              color: isDisabled 
                  ? AppColors.textLight 
                  : (textColor ?? AppColors.primaryPink),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          child: _buildButtonContent(theme),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryPink,
          foregroundColor: textColor ?? Colors.white,
          elevation: isDisabled ? 0 : 2,
          shadowColor: (backgroundColor ?? AppColors.primaryPink).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: _buildButtonContent(theme),
      ),
    );
  }

  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined 
                ? (textColor ?? AppColors.primaryPink)
                : Colors.white,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isOutlined 
                  ? (textColor ?? AppColors.primaryPink)
                  : Colors.white,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(
        color: isOutlined 
            ? (textColor ?? AppColors.primaryPink)
            : Colors.white,
      ),
    );
  }
}
