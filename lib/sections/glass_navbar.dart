import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moeez_portfolio/constants/app_strings.dart';

import '../widgets/typewriter_text.dart';

class GlassNavbar extends StatefulWidget {
  final VoidCallback onLogoTap;
  final VoidCallback onWorkTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;
  final VoidCallback onResumeTap;

  const GlassNavbar({
    super.key,
    required this.onLogoTap,
    required this.onWorkTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
    required this.onResumeTap,
  });

  @override
  State<GlassNavbar> createState() => _GlassNavbarState();
}

class _GlassNavbarState extends State<GlassNavbar> {
  bool _menuOpen = false;
  static const double _mobileNavHeight = 74;
  static const double _mobileMenuTopOffset = 74;
  static const double _mobileMenuHeight = 300;

  void _toggleMenu() {
    setState(() => _menuOpen = !_menuOpen);
  }

  void _closeMenu() {
    if (!_menuOpen) return;
    setState(() => _menuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    final nav = _NavShell(
      isDesktop: isDesktop,
      onLogoTap: () {
        _closeMenu();
        widget.onLogoTap();
      },
      onWorkTap: () {
        _closeMenu();
        widget.onWorkTap();
      },
      onAboutTap: () {
        _closeMenu();
        widget.onAboutTap();
      },
      onServicesTap: () {
        _closeMenu();
        widget.onServicesTap();
      },
      onContactTap: () {
        _closeMenu();
        widget.onContactTap();
      },
      onResumeTap: () {
        _closeMenu();
        widget.onResumeTap();
      },
      onMenuTap: _toggleMenu,
    );

    return Positioned(
      top: 24,
      left: isDesktop ? 40 : 16,
      right: isDesktop ? 40 : 16,
      child: SizedBox(
        height: isDesktop
            ? _mobileNavHeight
            : (_menuOpen
                  ? _mobileNavHeight + _mobileMenuHeight
                  : _mobileNavHeight),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            nav,
            if (!isDesktop)
              Positioned(
                top: _mobileMenuTopOffset,
                right: 0,
                child: _MobileMenu(
                  open: _menuOpen,
                  onWorkTap: widget.onWorkTap,
                  onAboutTap: widget.onAboutTap,
                  onServicesTap: widget.onServicesTap,
                  onContactTap: widget.onContactTap,
                  onClose: _closeMenu,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavShell extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onLogoTap;
  final VoidCallback onWorkTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;
  final VoidCallback onResumeTap;
  final VoidCallback onMenuTap;

  const _NavShell({
    required this.isDesktop,
    required this.onLogoTap,
    required this.onWorkTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
    required this.onResumeTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              _BrandButton(onTap: onLogoTap),
              if (isDesktop) ...[
                const Spacer(),
                Row(
                  children: [
                    _NavItem(label: AppStrings.workLink, onTap: onWorkTap),
                    const SizedBox(width: 32),
                    _NavItem(label: AppStrings.aboutLink, onTap: onAboutTap),
                    const SizedBox(width: 32),
                    _NavItem(
                      label: AppStrings.servicesLink,
                      onTap: onServicesTap,
                    ),
                    const SizedBox(width: 32),
                    _NavItem(
                      label: AppStrings.contactLink,
                      onTap: onContactTap,
                    ),
                  ],
                ),
                const Spacer(),
                _PillButton(
                  label: AppStrings.resumeLink,
                  onTap: onResumeTap,
                  background: const Color(0xFFFEEC81),
                  foreground: const Color(0xFF1A1A1A),
                ),
              ] else ...[
                const Spacer(),
                _PillButton(
                  label: AppStrings.resumeLink,
                  onTap: onResumeTap,
                  background: const Color(0xFFFEEC81),
                  foreground: const Color(0xFF1A1A1A),
                ),
                const SizedBox(width: 10),
                _IconButton(icon: Icons.menu, onTap: onMenuTap),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _BrandButton extends StatefulWidget {
  final VoidCallback onTap;

  const _BrandButton({required this.onTap});

  @override
  State<_BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<_BrandButton> {
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
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.98 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? Colors.black.withValues(alpha: 0.04)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.catching_pokemon, size: 24),
                const SizedBox(width: 8),
                const Text(
                  AppStrings.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1A1A1A),
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

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovered ? const Color(0xFF1A1A1A) : Colors.grey[700];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.98 : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 140),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                height: 2,
                width: _hovered ? 18 : 0,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Color background;
  final Color foreground;

  const _PillButton({
    required this.label,
    required this.onTap,
    required this.background,
    required this.foreground,
  });

  @override
  State<_PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<_PillButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    // Normal: background from props.
    // Hover: Black (0xFF1A1A1A).
    final bg = _hovered ? const Color(0xFF1A1A1A) : widget.background;

    // Normal: foreground from props.
    // Hover: White.
    final fg = _hovered ? Colors.white : widget.foreground;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.98 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(50),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : null,
            ),
            child: TypewriterText(
              text: widget.label,
              active: _hovered,
              style: TextStyle(
                color: fg,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  State<_IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<_IconButton> {
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
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.96 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hovered
                  ? Colors.black.withValues(alpha: 0.04)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(widget.icon, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final bool open;
  final VoidCallback onWorkTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;
  final VoidCallback onClose;

  const _MobileMenu({
    required this.open,
    required this.onWorkTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !open,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: open ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 160),
          offset: open ? Offset.zero : const Offset(0, -0.05),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 220,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.15),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MobileMenuItem(
                      label: AppStrings.workLink,
                      onTap: () {
                        onClose();
                        onWorkTap();
                      },
                    ),
                    _MobileMenuItem(
                      label: AppStrings.aboutLink,
                      onTap: () {
                        onClose();
                        onAboutTap();
                      },
                    ),
                    _MobileMenuItem(
                      label: AppStrings.servicesLink,
                      onTap: () {
                        onClose();
                        onServicesTap();
                      },
                    ),
                    _MobileMenuItem(
                      label: AppStrings.contactLink,
                      onTap: () {
                        onClose();
                        onContactTap();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _MobileMenuItem({required this.label, required this.onTap});

  @override
  State<_MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<_MobileMenuItem> {
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
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.98 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: _hovered
                  ? Colors.black.withValues(alpha: 0.04)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobilePrimary extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _MobilePrimary({required this.label, required this.onTap});

  @override
  State<_MobilePrimary> createState() => _MobilePrimaryState();
}

class _MobilePrimaryState extends State<_MobilePrimary> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    // Current yellow or black on hover
    final bg = _hovered ? const Color(0xFF1A1A1A) : const Color(0xFFFEEC81);
    final fg = _hovered ? Colors.white : const Color(0xFF1A1A1A);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.98 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TypewriterText(
              text: widget.label,
              active: _hovered,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
