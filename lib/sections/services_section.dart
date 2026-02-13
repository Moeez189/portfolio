import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

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
                '## ',
                style: TextStyle(
                  fontSize: isDesktop ? 42 : 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                'Services',
                style: TextStyle(
                  fontSize: isDesktop ? 42 : 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: 16),

          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Creating tailored digital solutions that solve real-world problems. From concept to launch, I bring ideas to life with precision and creativity.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

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
                title: 'Web Development',
                description:
                    'Building responsive, high-performance websites tailored to your needs. From sleek portfolios to robust e-commerce platforms, I create digital experiences that work seamlessly across devices.',
                color: const Color(0xFFE6F0FF),
                delay: 0,
              ),
              _buildServiceCard(
                icon: Icons.phone_iphone_rounded,
                title: 'Mobile App Development',
                description:
                    'Designing and developing intuitive mobile apps for iOS and Android. Whether it\'s a startup idea or an enterprise solution, I bring your vision to life with clean code and user-friendly interfaces.',
                color: const Color(0xFFFFF4E6),
                delay: 100,
              ),
              _buildServiceCard(
                icon: Icons.shopping_cart_rounded,
                title: 'E-Commerce Development',
                description:
                    'Creating powerful, scalable e-commerce websites that drive sales and enhance user experience. From product listings to secure payment gateways, I build platforms that grow your business.',
                color: const Color(0xFFE8F4EA),
                delay: 200,
              ),
              _buildServiceCard(
                icon: Icons.settings_rounded,
                title: 'Custom Software Solutions',
                description:
                    'Developing bespoke software to solve unique business challenges. From automation tools to scalable systems, I deliver tailored solutions that drive efficiency and growth.',
                color: const Color(0xFFF4E6FF),
                delay: 300,
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
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay + 300),
          duration: 600.ms,
        )
        .slideY(begin: 0.1);
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
