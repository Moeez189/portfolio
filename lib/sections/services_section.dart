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

  static const List<_ServiceVisual> _serviceVisuals = [
    _ServiceVisual(
      icon: Icons.phone_iphone_rounded,
      accent: Color(0xFF0F4C81),
      tint: Color(0xFFE8F2FF),
      border: Color(0xFFB6D0FF),
    ),
    _ServiceVisual(
      icon: Icons.android_rounded,
      accent: Color(0xFF2E7D32),
      tint: Color(0xFFE8F7E8),
      border: Color(0xFFBDE3BF),
    ),
    _ServiceVisual(
      icon: Icons.storefront_rounded,
      accent: Color(0xFFB25E09),
      tint: Color(0xFFFFF3E4),
      border: Color(0xFFFFDCB6),
    ),
    _ServiceVisual(
      icon: Icons.api_rounded,
      accent: Color(0xFF0D9488),
      tint: Color(0xFFE6FAF8),
      border: Color(0xFFBAECE8),
    ),
    _ServiceVisual(
      icon: Icons.speed_rounded,
      accent: Color(0xFF9A3412),
      tint: Color(0xFFFFEFE8),
      border: Color(0xFFF8CCBC),
    ),
    _ServiceVisual(
      icon: Icons.bug_report_rounded,
      accent: Color(0xFF374151),
      tint: Color(0xFFF1F3F6),
      border: Color(0xFFD4DBE5),
    ),
    _ServiceVisual(
      icon: Icons.rocket_launch_rounded,
      accent: Color(0xFF0F766E),
      tint: Color(0xFFE6F8F6),
      border: Color(0xFFBCEAE5),
    ),
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
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  AppStrings.servicesSectionDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.65,
                  ),
                ),
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 180.ms, duration: 760.ms)
              .slideY(begin: 0.1, duration: 760.ms),
          const SizedBox(height: 46),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final int columns = width >= 1200
                  ? 3
                  : width >= 760
                  ? 2
                  : 1;

              final double childAspectRatio = columns == 1
                  ? 1.35
                  : columns == 2
                  ? 1.08
                  : 0.94;

              return GridView.builder(
                itemCount: AppStrings.services.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 26,
                  crossAxisSpacing: 22,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  return _StackServiceCard(
                        service: AppStrings.services[index],
                        visual: _serviceVisuals[index % _serviceVisuals.length],
                        compact: columns == 1,
                      )
                      .animate(
                        controller: animationController,
                        autoPlay: autoPlay,
                        target: target,
                      )
                      .fadeIn(
                        delay: Duration(milliseconds: 90 * index),
                        duration: 700.ms,
                      )
                      .slideY(begin: 0.08, duration: 700.ms);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StackServiceCard extends StatefulWidget {
  final ServiceItem service;
  final _ServiceVisual visual;
  final bool compact;

  const _StackServiceCard({
    required this.service,
    required this.visual,
    required this.compact,
  });

  @override
  State<_StackServiceCard> createState() => _StackServiceCardState();
}

class _StackServiceCardState extends State<_StackServiceCard> {
  bool _hovered = false;
  bool _pressed = false;

  static const Duration _motion = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final bool enableHover = !widget.compact;
    final bool hovered = enableHover && _hovered;

    final Offset backLayerA = hovered
        ? const Offset(18, 16)
        : const Offset(14, 14);
    final Offset backLayerB = hovered
        ? const Offset(11, 10)
        : const Offset(8, 8);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: _motion,
          curve: Curves.easeOut,
          scale: _pressed
              ? 0.985
              : hovered
              ? 1.01
              : 1.0,
          child: AnimatedContainer(
            duration: _motion,
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: AnimatedSlide(
                    duration: _motion,
                    curve: Curves.easeOut,
                    offset: Offset(backLayerA.dx / 340, backLayerA.dy / 220),
                    child: _BackPlate(
                      color: widget.visual.tint.withValues(alpha: 0.55),
                      border: widget.visual.border.withValues(alpha: 0.55),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedSlide(
                    duration: _motion,
                    curve: Curves.easeOut,
                    offset: Offset(backLayerB.dx / 340, backLayerB.dy / 220),
                    child: _BackPlate(
                      color: widget.visual.tint.withValues(alpha: 0.72),
                      border: widget.visual.border.withValues(alpha: 0.72),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: _motion,
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: widget.visual.border.withValues(
                          alpha: hovered ? 0.9 : 0.62,
                        ),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          widget.visual.tint.withValues(alpha: 0.22),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: hovered ? 0.13 : 0.07,
                          ),
                          blurRadius: hovered ? 34 : 24,
                          offset: Offset(0, hovered ? 20 : 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: _motion,
                              curve: Curves.easeOut,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: widget.visual.accent.withValues(
                                  alpha: hovered ? 0.2 : 0.14,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.visual.icon,
                                size: 21,
                                color: widget.visual.accent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.service.title,
                                style: const TextStyle(
                                  fontSize: 16.2,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                  color: Color(0xFF171717),
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            widget.service.description,
                            style: TextStyle(
                              fontSize: 13.2,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                              color: Colors.grey[700],
                            ),
                            maxLines: widget.compact ? 4 : 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedAlign(
                          duration: _motion,
                          curve: Curves.easeOut,
                          alignment: hovered
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Icon(
                            Icons.north_east_rounded,
                            size: 18,
                            color: widget.visual.accent.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackPlate extends StatelessWidget {
  final Color color;
  final Color border;

  const _BackPlate({required this.color, required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
    );
  }
}

class _ServiceVisual {
  final IconData icon;
  final Color accent;
  final Color tint;
  final Color border;

  const _ServiceVisual({
    required this.icon,
    required this.accent,
    required this.tint,
    required this.border,
  });
}
