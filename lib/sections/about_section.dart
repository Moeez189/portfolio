import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_strings.dart';

class AboutSection extends StatelessWidget {
  final VoidCallback? onMoreAboutTap;
  final AnimationController? animationController;
  final bool animate;

  const AboutSection({
    super.key,
    this.onMoreAboutTap,
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
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
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
                    AppStrings.aboutSectionTitle,
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

          // Subtitle
          Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  AppStrings.aboutSectionDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              )
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 200.ms, duration: 800.ms)
              .slideY(begin: 0.1, duration: 800.ms),

          const SizedBox(height: 60),

          // About Content
          (isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image Placeholder
                        Expanded(flex: 1, child: _buildImageSection()),
                        const SizedBox(width: 60),
                        // Info Cards
                        Expanded(flex: 1, child: _buildInfoSection(isDesktop)),
                      ],
                    )
                  : Column(
                      children: [
                        _buildImageSection(),
                        const SizedBox(height: 40),
                        _buildInfoSection(isDesktop),
                      ],
                    ))
              .animate(
                controller: animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 400.ms, duration: 800.ms)
              .slideY(begin: 0.1, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8E6E3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            AppStrings.aboutProfileImagePath,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                Icons.broken_image_outlined,
                size: 48,
                color: Colors.grey[500],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideX(begin: -0.1);
  }

  Widget _buildInfoSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 30 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.aboutProfileName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.aboutProfileRole,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 26),
          TextButton(
            onPressed: onMoreAboutTap,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1A1A1A),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            ),
            child: const Text(
              AppStrings.aboutMoreButton,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: 0.1);
  }
}
