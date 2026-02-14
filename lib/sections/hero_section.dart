import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_strings.dart';
import '../widgets/typewriter_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetInTouchTap;
  final AnimationController? animationController;
  final bool animate;

  const HeroSection({
    super.key,
    this.onGetInTouchTap,
    this.animationController,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    // If animate is false, we force end state (target = 1)
    // If animate is true, we use controller or autoPlay
    final double? target = animate ? null : 1.0;
    final bool autoPlay = animate && (animationController == null);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: isDesktop ? 120 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main Title - Animated Word by Word
          _AnimatedWordText(
            text: AppStrings.heroTitle,
            isDesktop: isDesktop,
            controller: animationController,
            baseDelay: 0,
            autoPlay: autoPlay,
            target: target,
          ),
          const SizedBox(height: 8),
          _AnimatedWordText(
            text: AppStrings.heroSubTitle,
            isDesktop: isDesktop,
            controller: animationController,
            baseDelay: 300,
            autoPlay: autoPlay,
            target: target,
          ),
          const SizedBox(height: 32),
          // Subtitle
          Container(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  AppStrings.heroDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 17 : 15,
                    color: Colors.grey[600],
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 600.ms, duration: 600.ms),
          const SizedBox(height: 40),
          _HeroCtaButton(onTap: onGetInTouchTap)
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 800.ms)
              .scale(begin: const Offset(0.95, 0.95), duration: 400.ms),
        ],
      ),
    );
  }
}

class _AnimatedWordText extends StatelessWidget {
  final String text;
  final bool isDesktop;
  final AnimationController? controller;
  final double baseDelay;
  final bool autoPlay;
  final double? target;

  const _AnimatedWordText({
    required this.text,
    required this.isDesktop,
    this.controller,
    required this.baseDelay,
    required this.autoPlay,
    this.target,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: isDesktop ? 12 : 8,
      runSpacing: isDesktop ? 8 : 4,
      children: words.asMap().entries.map((entry) {
        final index = entry.key;
        final word = entry.value;
        return Text(
              word,
              style: TextStyle(
                fontSize: isDesktop ? 64 : 36,
                fontWeight: FontWeight.w700,
                height: 1.15,
                letterSpacing: -1.5,
                color: const Color(0xFF1A1A1A),
              ),
            )
            .animate(controller: controller, autoPlay: autoPlay, target: target)
            .fadeIn(
              duration: 600.ms,
              delay: (baseDelay + index * 100).ms,
              curve: Curves.easeOut,
            )
            .slideY(
              begin: 0.2, // Slide up effect
              end: 0,
              duration: 600.ms,
              curve: Curves.easeOut,
            );
      }).toList(),
    );
  }
}

class _HeroCtaButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _HeroCtaButton({this.onTap});

  @override
  State<_HeroCtaButton> createState() => _HeroCtaButtonState();
}

class _HeroCtaButtonState extends State<_HeroCtaButton> {
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
          scale: _pressed ? 0.98 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            decoration: BoxDecoration(
              color: _hovered ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: _hovered ? 26 : 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: TypewriterText(
                text: AppStrings.getInTouchButton,
                active: _hovered,
                style: TextStyle(
                  color: _hovered ? Colors.white : const Color(0xFF1A1A1A),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
