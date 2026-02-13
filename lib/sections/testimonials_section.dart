import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<Map<String, String>> testimonials = [
    {
      'quote':
          "Working with them was a game-changer! Their attention to detail and ability to deliver on time made our project a huge success. Highly recommend!",
      'name': 'Ahmed Khan',
      'role': 'Product Owner @TechFlow',
    },
    {
      'quote':
          "The app they built for us is not only stunning but also incredibly functional. They truly understand how to balance design and performance.",
      'name': 'Sarah Williams',
      'role': 'Founder @StartupX',
    },
    {
      'quote':
          "Exceptional work! The mobile application exceeded our expectations in terms of quality and delivery timeline. A true professional.",
      'name': 'Michael Chen',
      'role': 'CTO @InnovateCo',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                  fontSize: isDesktop ? 42 : 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[400],
                ),
              ),
              Flexible(
                child: Text(
                  'Always happy to help creative people launch their projects',
                  style: TextStyle(
                    fontSize: isDesktop ? 42 : 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms),

          const SizedBox(height: 60),

          // Testimonials Carousel
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return _buildTestimonialCard(
                  quote: testimonials[index]['quote']!,
                  name: testimonials[index]['name']!,
                  role: testimonials[index]['role']!,
                  isActive: index == _currentPage,
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          // Navigation Arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavButton(
                icon: Icons.arrow_back_rounded,
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const SizedBox(width: 20),
              // Page indicators
              Row(
                children: List.generate(
                  testimonials.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == _currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == _currentPage
                          ? const Color(0xFF1A1A1A)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _buildNavButton(
                icon: Icons.arrow_forward_rounded,
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String quote,
    required String name,
    required String role,
    required bool isActive,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isActive ? 1.0 : 0.5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote_rounded, size: 32, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                quote,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, color: Colors.grey[400]),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
        ),
      ),
    );
  }
}
