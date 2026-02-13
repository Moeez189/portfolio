import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_strings.dart';
import 'typewriter_text.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onGetInTouchTap;
  final AnimationController? animationController;
  final bool animate;

  const FooterSection({
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
          // Contact CTA Section
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
          SizedBox(height: isDesktop ? 160 : 80),
          // Footer Bottom Row
          Container(
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.05)),
                  ),
                ),
                child: isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.copyrightText,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Row(
                            children: [
                              _FooterLink(AppStrings.emailAddress),
                              const SizedBox(width: 24),
                              _FooterLink(AppStrings.twitterLink),
                              const SizedBox(width: 24),
                              _FooterLink(AppStrings.linkedInLink),
                              const SizedBox(width: 24),
                              _madeInBadge(),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 10,
                            children: [
                              _FooterLink(AppStrings.emailAddress),
                              _FooterLink(AppStrings.twitterLink),
                              _FooterLink(AppStrings.linkedInLink),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _madeInBadge(),
                          const SizedBox(height: 24),
                          Text(
                            AppStrings.copyrightText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 400.ms, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _madeInBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.flash_on_rounded, size: 14, color: Colors.black),
          const SizedBox(width: 6),
          const Text(
            AppStrings.madeInFlutter,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _hovered ? Colors.black : Colors.grey[700],
        ),
        child: Text(widget.text),
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
