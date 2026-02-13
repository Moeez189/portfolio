import 'dart:math';
import 'package:flutter/material.dart';

class PremiumBackground extends StatefulWidget {
  const PremiumBackground({super.key});

  @override
  State<PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<PremiumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          children: [
            Container(color: const Color(0xfff6f4f1)), // base soft cream

            _blob(
              color: const Color(0xffb3e5fc),
              dx: sin(controller.value * 2 * pi) * 200,
              dy: cos(controller.value * 2 * pi) * 150,
            ),

            _blob(
              color: const Color(0xfff6d365),
              dx: cos(controller.value * 2 * pi) * 180,
              dy: sin(controller.value * 2 * pi) * 180,
            ),

            _blob(
              color: const Color(0xffc3bef0),
              dx: sin(controller.value * 2 * pi + 2) * 220,
              dy: cos(controller.value * 2 * pi + 2) * 200,
            ),
          ],
        );
      },
    );
  }

  Widget _blob({required Color color, required double dx, required double dy}) {
    return Positioned(
      left: dx,
      top: dy,
      child: Container(
        width: 700,
        height: 700,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 200,
              spreadRadius: 100,
            ),
          ],
        ),
      ),
    );
  }
}
