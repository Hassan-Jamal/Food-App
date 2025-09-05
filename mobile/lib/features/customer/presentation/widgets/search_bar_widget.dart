import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final String? initialValue;
  final String? hintText;

  const SearchBarWidget({
    super.key,
    required this.onSearchChanged,
    this.initialValue,
    this.hintText,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
    widget.onSearchChanged(value);
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _isSearching = false;
    });
    widget.onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Search restaurants or dishes...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textLight,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textMedium,
            size: 24,
          ),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.textMedium,
                    size: 20,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
