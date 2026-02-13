import 'dart:math';
import 'package:flutter/material.dart';

class GradientBackground extends StatefulWidget {
  const GradientBackground({super.key});

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.hasBoundedHeight && constraints.maxHeight > 0
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;

        final width = constraints.hasBoundedWidth && constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final drift = sin(_controller.value * 2 * pi) * 0.02;
            final double leftStop = (0.38 + drift).clamp(0.28, 0.48).toDouble();
            final double rightStop = (0.62 + drift)
                .clamp(0.52, 0.72)
                .toDouble();

            final double topBandHeight = height > 650 ? 650 : height;
            final double fadeHeight = height > 800 ? 800 : height;

            return Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(color: Color(0xFFFAF9F6)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: topBandHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: const [
                            Color(0xFFB8F0B8),
                            Color(0xFF67FAE8),
                            Color(0xFF67FAE8),
                            Color(0xFFFEEC81),
                          ],
                          stops: [0.0, leftStop, rightStop, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: fadeHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00FAF9F6), Color(0xFFFAF9F6)],
                          stops: [0.0, 0.85],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
