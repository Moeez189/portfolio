import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final VoidCallback? onGetInTouchTap;
  final VoidCallback? onWorkTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onContactTap;

  const ContactSection({
    super.key,
    this.onGetInTouchTap,
    this.onWorkTap,
    this.onAboutTap,
    this.onServicesTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 110,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let’s build your website together",
                style: TextStyle(
                  fontSize: isDesktop ? 44 : 32,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  letterSpacing: -1.0,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: _FooterCtaButton(onTap: onGetInTouchTap),
              ),
              const SizedBox(height: 26),
              Wrap(
                spacing: 14,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '© 2025 — All rights reserved.',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  Text(
                    'hello@yourdomain.com',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    'Twitter',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    'LinkedIn',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Additional Links',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                children: [
                  _linkChip('Work', onWorkTap),
                  _linkChip('About', onAboutTap),
                  _linkChip('Services', onServicesTap),
                  _linkChip('Contact', onContactTap),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkChip(String label, VoidCallback? onTap) {
    return _FooterLinkChip(label: label, onTap: onTap);
  }
}

class _FooterCtaButton extends StatefulWidget {
  final VoidCallback? onTap;

  const _FooterCtaButton({this.onTap});

  @override
  State<_FooterCtaButton> createState() => _FooterCtaButtonState();
}

class _FooterCtaButtonState extends State<_FooterCtaButton> {
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: _hovered ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: _hovered ? 24 : 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: _TypewriterText(
                text: 'Get in touch',
                active: _hovered,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _hovered ? Colors.white : const Color(0xFF1A1A1A),
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

class _FooterLinkChip extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _FooterLinkChip({required this.label, required this.onTap});

  @override
  State<_FooterLinkChip> createState() => _FooterLinkChipState();
}

class _FooterLinkChipState extends State<_FooterLinkChip> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
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
          scale: _pressed ? 0.98 : (_hovered ? 1.02 : 1.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey.withValues(alpha: _hovered ? 0.28 : 0.2),
              ),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
