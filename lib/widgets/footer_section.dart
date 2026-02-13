import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_strings.dart';

class FooterSection extends StatelessWidget {
  final AnimationController? animationController;
  final bool animate;

  const FooterSection({
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
        vertical: 40,
      ),
      child:
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
