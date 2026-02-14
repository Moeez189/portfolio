import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_strings.dart';

class ServicesSection extends StatelessWidget {
  final AnimationController? animationController;
  final bool animate;

  const ServicesSection({
    super.key,
    this.animationController,
    this.animate = true,
  });

  static const List<IconData> _serviceIcons = [
    Icons.phone_iphone_rounded,
    Icons.android_rounded,
    Icons.storefront_rounded,
    Icons.api_rounded,
    Icons.speed_rounded,
    Icons.bug_report_rounded,
    Icons.rocket_launch_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    final double? target = animate ? null : 1.0;
    final bool autoPlay = animate && (animationController == null);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                children: [
                  Text(
                    AppStrings.sectionPrefix,
                    style: TextStyle(
                      fontSize: isDesktop ? 42 : 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    AppStrings.servicesSectionTitle,
                    style: TextStyle(
                      fontSize: isDesktop ? 42 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(duration: 800.ms)
              .slideY(begin: 0.1, duration: 800.ms),
          const SizedBox(height: 16),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  AppStrings.servicesSectionDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 200.ms, duration: 800.ms)
              .slideY(begin: 0.1, duration: 800.ms),
          const SizedBox(height: 44),
          GridView.builder(
            itemCount: AppStrings.services.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: isDesktop ? 1.7 : 1.25,
            ),
            itemBuilder: (context, index) {
              final service = AppStrings.services[index];
              return _buildServiceCard(
                icon: _serviceIcons[index],
                title: service.title,
                description: service.description,
                delay: index * 110,
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
    AnimationController? controller,
    bool autoPlay = true,
    double? target,
  }) {
    return _ServiceHoverPress(
          builder: (hovered, pressed) {
            return Transform.translate(
              offset: Offset(0, hovered ? -6 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: hovered
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 14),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                  border: Border.all(
                    color: Colors.black.withValues(
                      alpha: hovered ? 0.08 : 0.04,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        size: 22,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
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
}

typedef _ServiceHoverBuilder = Widget Function(bool hovered, bool pressed);

class _ServiceHoverPress extends StatefulWidget {
  final _ServiceHoverBuilder builder;

  const _ServiceHoverPress({required this.builder});

  @override
  State<_ServiceHoverPress> createState() => _ServiceHoverPressState();
}

class _ServiceHoverPressState extends State<_ServiceHoverPress> {
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
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () {},
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.99 : (_hovered ? 1.01 : 1.0),
          child: widget.builder(_hovered, _pressed),
        ),
      ),
    );
  }
}
