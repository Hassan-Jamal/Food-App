import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessAnimation extends StatelessWidget {
  const OrderSuccessAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lottie/success.json', width: 220, repeat: false),
    );
  }
}

