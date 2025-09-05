import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedEmptyState extends StatelessWidget {
  const AnimatedEmptyState({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset('assets/lottie/empty.json', width: 180, repeat: false, fit: BoxFit.contain),
        const SizedBox(height: 12),
        Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

