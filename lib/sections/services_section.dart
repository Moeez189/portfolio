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
          // Section Title
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

          Container(
                constraints: const BoxConstraints(maxWidth: 600),
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

          const SizedBox(height: 60),

          // Services Grid
          GridView.count(
            crossAxisCount: isDesktop ? 2 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: isDesktop ? 1.8 : 1.4,
            children: [
              _buildServiceCard(
                icon: Icons.web_rounded,
                title: AppStrings.webDevelopmentTitle,
                description: AppStrings.webDevelopmentDescription,
                color: const Color(0xFFE6F0FF),
                delay: 0,
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              ),
              _buildServiceCard(
                icon: Icons.phone_iphone_rounded,
                title: AppStrings.mobileAppDevelopmentTitle,
                description: AppStrings.mobileAppDevelopmentDescription,
                color: const Color(0xFFFFF4E6),
                delay: 150,
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              ),
              _buildServiceCard(
                icon: Icons.shopping_cart_rounded,
                title: AppStrings.ecommerceDevelopmentTitle,
                description: AppStrings.ecommerceDevelopmentDescription,
                color: const Color(0xFFE8F4EA),
                delay: 300,
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              ),
              _buildServiceCard(
                icon: Icons.settings_rounded,
                title: AppStrings.customSoftwareSolutionsTitle,
                description: AppStrings.customSoftwareSolutionsDescription,
                color: const Color(0xFFF4E6FF),
                delay: 450,
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
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
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: hovered
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 26,
                            offset: const Offset(0, 14),
                          ),
                        ]
                      : null,
                  border: Border.all(
                    color: Colors.black.withValues(alpha: hovered ? 0.06 : 0.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        size: 24,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
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
