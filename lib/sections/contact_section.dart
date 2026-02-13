import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/typewriter_text.dart';
import '../constants/app_strings.dart';

class ContactSection extends StatelessWidget {
  final VoidCallback? onGetInTouchTap;
  final AnimationController? animationController;
  final bool animate;

  const ContactSection({
    super.key,
    this.onGetInTouchTap,
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
      padding: EdgeInsets.only(
        left: isDesktop ? 80 : 24,
        right: isDesktop ? 80 : 24,
        top: isDesktop ? 100 : 60,
        bottom: isDesktop ? 40 : 10,
      ),
      child: Column(
        children: [
          SizedBox(height: isDesktop ? 40 : 20),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Spot Gradient Behind Text
                Positioned(
                  top: isDesktop ? -100 : -50,
                  bottom: isDesktop ? -250 : -150,
                  left: isDesktop ? -250 : -150,
                  right: isDesktop ? -250 : -150,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFEEC81).withOpacity(0.9),
                          const Color(0xFFFAF9F6).withOpacity(0),
                        ],
                        center: Alignment.center,
                        radius: 0.7,
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Text(
                            AppStrings.contactHeading,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 64 : 36,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                              letterSpacing: isDesktop ? -1.5 : -0.5,
                              color: const Color(0xFF1A1A1A),
                            ),
                          )
                          .animate(
                            controller: animationController,
                            autoPlay: autoPlay,
                            target: target,
                          )
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.1, duration: 800.ms),
                      const SizedBox(height: 40),
                      _ContactCtaButton(onTap: onGetInTouchTap)
                          .animate(
                            controller: animationController,
                            autoPlay: autoPlay,
                            target: target,
                          )
                          .fadeIn(delay: 200.ms, duration: 800.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            duration: 800.ms,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 80 : 40),
        ],
      ),
    );
  }
}

class _ContactCtaButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _ContactCtaButton({this.onTap});

  @override
  State<_ContactCtaButton> createState() => _ContactCtaButtonState();
}

class _ContactCtaButtonState extends State<_ContactCtaButton> {
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
