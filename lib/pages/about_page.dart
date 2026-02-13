import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../sections/glass_navbar.dart';
import '../sections/gradient_background.dart';
import '../utils/url_fragment.dart' as url_fragment;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _navFading = false;

  Future<void> _fadeOverlayThen(VoidCallback action) async {
    if (_navFading) {
      action();
      return;
    }

    setState(() => _navFading = true);
    await Future.delayed(const Duration(milliseconds: 240));
    if (!mounted) return;
    action();
    await Future.delayed(const Duration(milliseconds: 180));
    if (!mounted) return;
    setState(() => _navFading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                const Positioned.fill(child: GradientBackground()),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 80 : 24,
                    vertical: 120,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 980),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Turning ideas into digital reality — one line of code at a time.',
                            style: TextStyle(
                              fontSize: isDesktop ? 52 : 34,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                              letterSpacing: -1.2,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Container(
                            height: isDesktop ? 420 : 260,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.15),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.workspaces_outline,
                                size: 64,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            "Hi, I’m Muhammad Moeez, a software developer with a passion for building digital solutions that make an impact.\n\nI specialize in creating web and mobile applications that are not only functional but also intuitive and visually appealing. Over the years, I’ve worked with startups, small businesses, and creative professionals to bring their ideas to life—whether it’s a sleek portfolio, a robust e-commerce platform, or a custom software solution.\n\nWhat drives me is the challenge of solving real-world problems through code. I believe in crafting experiences that are user-centric, scalable, and future-proof. From brainstorming to deployment, I’m involved in every step of the process to ensure the final product exceeds expectations.\n\nWhen I’m not coding, you’ll find me exploring the latest tech trends, tinkering with new frameworks, or brainstorming ways to make the web a better place. Let’s connect and build something amazing together!",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.8,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 60),
                          _FooterLinks(
                            onWorkTap: () {
                              context.go('/');
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                url_fragment.setFragment('work');
                              });
                            },
                            onServicesTap: () {
                              context.go('/');
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                url_fragment.setFragment('services');
                              });
                            },
                            onAboutTap: () => context.go('/about'),
                            onContactTap: () => context.go('/contact'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GlassNavbar(
            onLogoTap: () => _fadeOverlayThen(() {
              context.go('/');
              url_fragment.setFragment('');
            }),
            onWorkTap: () => _fadeOverlayThen(() {
              context.go('/');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment('work');
              });
            }),
            onAboutTap: () => _fadeOverlayThen(() => context.go('/about')),
            onServicesTap: () => _fadeOverlayThen(() {
              context.go('/');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment('services');
              });
            }),
            onContactTap: () => _fadeOverlayThen(() => context.go('/contact')),
            onResumeTap: () {},
          ),
          IgnorePointer(
            ignoring: !_navFading,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              opacity: _navFading ? 1 : 0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final VoidCallback onWorkTap;
  final VoidCallback onAboutTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;

  const _FooterLinks({
    required this.onWorkTap,
    required this.onAboutTap,
    required this.onServicesTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Links',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _linkButton('Work', onWorkTap),
            _linkButton('About', onAboutTap),
            _linkButton('Services', onServicesTap),
            _linkButton('Contact', onContactTap),
          ],
        ),
      ],
    );
  }

  Widget _linkButton(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1A1A1A),
        overlayColor: Colors.transparent,
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFF1A1A1A))),
    );
  }
}
