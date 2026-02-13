import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetInTouchTap;

  const HeroSection({super.key, this.onGetInTouchTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: isDesktop ? 120 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main Title - Clean black text like Framer site
          Text(
            'Software Developer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 64 : 36,
              fontWeight: FontWeight.w700,
              height: 1.15,
              letterSpacing: -1.5,
              color: const Color(0xFF1A1A1A),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
          Text(
                'Web & Mobile Applications',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 64 : 36,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  letterSpacing: -1.5,
                  color: const Color(0xFF1A1A1A),
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms, delay: 100.ms)
              .slideY(begin: 0.1),
          const SizedBox(height: 32),
          // Subtitle
          Container(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              "I'm a software developer specializing in building sleek, functional web and mobile applications. With a passion for clean code and user-centric design, I turn ideas into digital experiences that work beautifully and deliver results.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 17 : 15,
                color: Colors.grey[600],
                height: 1.7,
                fontWeight: FontWeight.w400,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
          const SizedBox(height: 40),
          _HeroCtaButton(onTap: onGetInTouchTap)
              .animate()
              .fadeIn(delay: 500.ms)
              .scale(begin: const Offset(0.95, 0.95), duration: 400.ms),
        ],
      ),
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
              child: _TypewriterText(
                text: 'Get in touch',
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

class _TypewriterText extends StatefulWidget {
  final String text;
  final bool active;
  final TextStyle style;

  const _TypewriterText({
    required this.text,
    required this.active,
    required this.style,
  });

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<int> _count;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _count = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant _TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text) {
      _count = StepTween(
        begin: 0,
        end: widget.text.length,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    }

    if (!oldWidget.active && widget.active) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      return Text(widget.text, style: widget.style);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: Text(widget.text, style: widget.style)),
        AnimatedBuilder(
          animation: _count,
          builder: (context, child) {
            final visible = widget.text.substring(0, _count.value);
            return Text(visible, style: widget.style);
          },
        ),
      ],
    );
  }
}
