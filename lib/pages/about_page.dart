import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_strings.dart';
import '../sections/glass_navbar.dart';
import '../sections/gradient_background.dart';
import '../widgets/footer_section.dart';
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
                Column(
                  children: [
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
                                AppStrings.aboutPageHeading,
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
                                AppStrings.aboutPageDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.8,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const FooterSection(),
                  ],
                ),
              ],
            ),
          ),

          /// Navbar
          GlassNavbar(
            onLogoTap: () => _fadeOverlayThen(() {
              context.go(AppStrings.routeHome);
              url_fragment.setFragment('');
            }),
            onWorkTap: () => _fadeOverlayThen(() {
              context.go(AppStrings.routeHome);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment(AppStrings.fragmentWork);
              });
            }),
            onAboutTap: () =>
                _fadeOverlayThen(() => context.go(AppStrings.routeAbout)),
            onServicesTap: () => _fadeOverlayThen(() {
              context.go(AppStrings.routeHome);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                url_fragment.setFragment(AppStrings.fragmentServices);
              });
            }),
            onContactTap: () =>
                _fadeOverlayThen(() => context.go(AppStrings.routeContact)),
            onResumeTap: () {},
          ),

          /// Fade Overlay
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
