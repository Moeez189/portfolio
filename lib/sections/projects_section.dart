import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatelessWidget {
  final AnimationController? animationController;
  final bool animate;

  const ProjectsSection({
    super.key,
    this.animationController,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    final double? target = animate ? null : 1.0;
    final bool autoPlay = animate && (animationController == null);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 16,
        vertical: 40,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildProjectCard(
                    title: 'Analytics Dashboard',
                    description:
                        'A data-driven dashboard for tracking key metrics. Intuitive interface, real-time updates, and widgets for businesses.',
                    gradientColors: const [
                      Color(0xFFB8E6B8),
                      Color(0xFF90EE90),
                    ],
                    mockupType: MockupType.dashboard,
                    delay: 0,
                    controller: animationController,
                    autoPlay: autoPlay,
                    target: target,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProjectCard(
                    title: 'Eyewear E-Commerce Site',
                    description:
                        'An immersive online store for a modern eyewear brand. Seamless navigation, and a personalized shopping experience.',
                    gradientColors: const [
                      Color(0xFFFFE066),
                      Color(0xFFFFD700),
                    ],
                    mockupType: MockupType.ecommerce,
                    delay: 150,
                    controller: animationController,
                    autoPlay: autoPlay,
                    target: target,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProjectCard(
                    title: 'FreshPages',
                    description:
                        'A high-conversion landing page built for a SaaS startup. Clean layout, bold visuals, and a focus on driving user action.',
                    gradientColors: const [
                      Color(0xFFFFB366),
                      Color(0xFFFF9933),
                    ],
                    mockupType: MockupType.landing,
                    delay: 300,
                    controller: animationController,
                    autoPlay: autoPlay,
                    target: target,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _buildProjectCard(
                  title: 'Analytics Dashboard',
                  description:
                      'A data-driven dashboard for tracking key metrics. Intuitive interface, real-time updates, and widgets for businesses.',
                  gradientColors: const [Color(0xFFB8E6B8), Color(0xFF90EE90)],
                  mockupType: MockupType.dashboard,
                  delay: 0,
                  controller: animationController,
                  autoPlay: autoPlay,
                  target: target,
                ),
                const SizedBox(height: 20),
                _buildProjectCard(
                  title: 'Eyewear E-Commerce Site',
                  description:
                      'An immersive online store for a modern eyewear brand. Seamless navigation, and a personalized shopping experience.',
                  gradientColors: const [Color(0xFFFFE066), Color(0xFFFFD700)],
                  mockupType: MockupType.ecommerce,
                  delay: 100,
                  controller: animationController,
                  autoPlay: autoPlay,
                  target: target,
                ),
                const SizedBox(height: 20),
                _buildProjectCard(
                  title: 'FreshPages',
                  description:
                      'A high-conversion landing page built for a SaaS startup. Clean layout, bold visuals, and a focus on driving user action.',
                  gradientColors: const [Color(0xFFFFB366), Color(0xFFFF9933)],
                  mockupType: MockupType.landing,
                  delay: 200,
                  controller: animationController,
                  autoPlay: autoPlay,
                  target: target,
                ),
              ],
            ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String description,
    required List<Color> gradientColors,
    required MockupType mockupType,
    required int delay,
    AnimationController? controller,
    bool autoPlay = true,
    double? target,
  }) {
    return _HoverPress(
          onTap: () {},
          builder: (hovered, pressed) {
            final y = hovered ? -6.0 : 0.0;
            final borderAlpha = hovered ? 0.22 : 0.15;
            final shadowAlpha = hovered ? 0.10 : 0.06;

            return Transform.translate(
              offset: Offset(0, y),
              child: Container(
                height: 420,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: borderAlpha),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: shadowAlpha),
                      blurRadius: hovered ? 34 : 30,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 24,
                      right: 24,
                      top: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 0,
                      child: _buildMockup(mockupType),
                    ),
                  ],
                ),
              ),
            );
          },
        )
        .animate(controller: controller, autoPlay: autoPlay, target: target)
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 800.ms,
        )
        .slideY(begin: 0.1, duration: 800.ms);
  }

  Widget _buildMockup(MockupType type) {
    switch (type) {
      case MockupType.dashboard:
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _dashboardMetric('Total', '12,345'),
                    const SizedBox(width: 12),
                    _dashboardMetric('Active', '8,234'),
                  ],
                ),
              ],
            ),
          ),
        );

      case MockupType.ecommerce:
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF2D5A4B),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Eyewear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.visibility,
                        color: Colors.white54,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      case MockupType.landing:
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFFFA726),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _dashboardMetric(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MockupType { dashboard, ecommerce, landing }

typedef _HoverPressBuilder = Widget Function(bool hovered, bool pressed);

class _HoverPress extends StatefulWidget {
  final VoidCallback? onTap;
  final _HoverPressBuilder builder;

  const _HoverPress({this.onTap, required this.builder});

  @override
  State<_HoverPress> createState() => _HoverPressState();
}

class _HoverPressState extends State<_HoverPress> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.99 : (_hovered ? 1.01 : 1.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 140),
            child: widget.builder(_hovered, _pressed),
          ),
        ),
      ),
    );
  }
}
