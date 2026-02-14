import 'dart:async';

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
          const SizedBox(height: 42),
          _ServicesDeck(services: AppStrings.services, visuals: _serviceVisuals)
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 250.ms, duration: 760.ms)
              .slideY(begin: 0.08, duration: 760.ms),
        ],
      ),
    );
  }
}

class _ServicesDeck extends StatefulWidget {
  final List<ServiceItem> services;
  final List<_ServiceVisual> visuals;

  const _ServicesDeck({required this.services, required this.visuals});

  @override
  State<_ServicesDeck> createState() => _ServicesDeckState();
}

class _ServicesDeckState extends State<_ServicesDeck> {
  int _activeIndex = 0;
  Timer? _autoAdvanceTimer;

  static const Duration _autoAdvanceDelay = Duration(seconds: 6);

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  @override
  void didUpdateWidget(covariant _ServicesDeck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.services.length != widget.services.length) {
      _activeIndex = 0;
      _startAutoAdvance();
    }
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    super.dispose();
  }

  int _indexAt(int offset) {
    return (_activeIndex + offset) % widget.services.length;
  }

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    if (widget.services.length <= 1) return;

    _autoAdvanceTimer = Timer.periodic(_autoAdvanceDelay, (_) {
      if (!mounted) return;
      _showNext();
    });
  }

  void _showNext({bool restartTimer = false}) {
    setState(() {
      _activeIndex = (_activeIndex + 1) % widget.services.length;
    });

    if (restartTimer) {
      _startAutoAdvance();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final cardHeight = isDesktop ? 330.0 : 350.0;

    final backOneIdx = _indexAt(1);
    final backTwoIdx = _indexAt(2);
    final activeVisual = widget.visuals[_activeIndex % widget.visuals.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: cardHeight + 42,
          child: Stack(
            children: [
              Positioned(
                left: 18,
                right: 18,
                top: 28,
                bottom: 0,
                child: _DeckShadowCard(
                  service: widget.services[backTwoIdx],
                  visual: widget.visuals[backTwoIdx % widget.visuals.length],
                  opacity: 0.38,
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 14,
                bottom: 0,
                child: _DeckShadowCard(
                  service: widget.services[backOneIdx],
                  visual: widget.visuals[backOneIdx % widget.visuals.length],
                  opacity: 0.62,
                ),
              ),
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 900),
                  reverseDuration: const Duration(milliseconds: 900),
                  switchInCurve: Curves.easeOutQuart,
                  switchOutCurve: Curves.easeInQuart,
                  transitionBuilder: (child, animation) {
                    final key = child.key as ValueKey<int>?;
                    final isIncoming = key?.value == _activeIndex;

                    final fade = isIncoming
                        ? Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: const Interval(0.25, 1.0),
                            ),
                          )
                        : Tween<double>(begin: 1.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeIn,
                            ),
                          );

                    final slide = isIncoming
                        ? Tween<Offset>(
                            begin: const Offset(0.05, 0),
                            end: Offset.zero,
                          ).animate(animation)
                        : Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(-0.05, 0),
                          ).animate(animation);

                    final scale = isIncoming
                        ? Tween<double>(
                            begin: 0.99,
                            end: 1.0,
                          ).animate(animation)
                        : Tween<double>(
                            begin: 1.0,
                            end: 0.97,
                          ).animate(animation);

                    return FadeTransition(
                      opacity: fade,
                      child: SlideTransition(
                        position: slide,
                        child: ScaleTransition(scale: scale, child: child),
                      ),
                    );
                  },
                  child: _InteractiveTopCard(
                    key: ValueKey<int>(_activeIndex),
                    service: widget.services[_activeIndex],
                    visual: activeVisual,
                    currentIndex: _activeIndex,
                    total: widget.services.length,
                    onNext: () => _showNext(restartTimer: true),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Auto-rotates every 6 seconds with a slower fade transition. Click to go next instantly.',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _InteractiveTopCard extends StatefulWidget {
  final ServiceItem service;
  final _ServiceVisual visual;
  final int currentIndex;
  final int total;
  final VoidCallback onNext;

  const _InteractiveTopCard({
    super.key,
    required this.service,
    required this.visual,
    required this.currentIndex,
    required this.total,
    required this.onNext,
  });

  @override
  State<_InteractiveTopCard> createState() => _InteractiveTopCardState();
}

class _InteractiveTopCardState extends State<_InteractiveTopCard> {
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
        behavior: HitTestBehavior.opaque,
        onTap: widget.onNext,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 140),
          scale: _pressed
              ? 0.985
              : _hovered
              ? 1.004
              : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.visual.border.withValues(
                  alpha: _hovered ? 0.95 : 0.76,
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  widget.visual.tint.withValues(alpha: 0.36),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _hovered ? 0.14 : 0.08),
                  blurRadius: _hovered ? 34 : 24,
                  offset: Offset(0, _hovered ? 20 : 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.visual.accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.visual.icon,
                        size: 22,
                        color: widget.visual.accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.service.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          color: Color(0xFF171717),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Text(
                    widget.service.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      height: 1.65,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _CardIndexPill(
                      current: widget.currentIndex + 1,
                      total: widget.total,
                      accent: widget.visual.accent,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.touch_app_rounded,
                      size: 18,
                      color: widget.visual.accent.withValues(alpha: 0.9),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: widget.visual.accent.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardIndexPill extends StatelessWidget {
  final int current;
  final int total;
  final Color accent;

  const _CardIndexPill({
    required this.current,
    required this.total,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$current / $total',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: accent,
        ),
      ),
    );
  }
}

class _DeckShadowCard extends StatelessWidget {
  final ServiceItem service;
  final _ServiceVisual visual;
  final double opacity;

  const _DeckShadowCard({
    required this.service,
    required this.visual,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: visual.tint.withValues(alpha: opacity),
        border: Border.all(color: visual.border.withValues(alpha: opacity)),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Icon(
              visual.icon,
              size: 14,
              color: visual.accent.withValues(alpha: 0.76),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                service.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
