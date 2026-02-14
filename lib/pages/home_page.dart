import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sections/about_section.dart';
import '../sections/glass_navbar.dart';
import '../sections/gradient_background.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/services_section.dart';
import '../sections/tech_stack_section.dart';
import '../widgets/section_animator.dart';
import '../widgets/footer_section.dart';
import '../constants/app_strings.dart';
import '../utils/url_fragment.dart' as url_fragment;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  bool _navFading = false;

  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollFromFragment();
    });

    url_fragment.fragmentNotifier.addListener(_scrollFromFragment);
  }

  @override
  void dispose() {
    url_fragment.fragmentNotifier.removeListener(_scrollFromFragment);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollFromFragment() {
    final fragment = Uri.base.fragment.isNotEmpty
        ? Uri.base.fragment
        : url_fragment.fragmentNotifier.value;

    if (!mounted) return;

    switch (fragment) {
      case AppStrings.fragmentWork:
        _scrollToSection(_workKey);
        break;
      case AppStrings.fragmentServices:
        _scrollToSection(_servicesKey);
        break;
      case AppStrings.fragmentContact:
        _scrollToSection(_contactKey);
        break;
      default:
        break;
    }
  }

  void _scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;
    if (sectionContext == null) return;

    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

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
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                const Positioned.fill(child: GradientBackground()),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdHero,
                      customAnimationBuilder: (_, controller) => HeroSection(
                        onGetInTouchTap: () =>
                            context.go(AppStrings.routeContact),
                        animationController: controller,
                      ),
                      child: HeroSection(
                        onGetInTouchTap: () =>
                            context.go(AppStrings.routeContact),
                        animate: false,
                      ),
                    ),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdProjects,
                      customAnimationBuilder: (_, controller) =>
                          ProjectsSection(
                            key: _workKey,
                            animationController: controller,
                          ),
                      child: ProjectsSection(key: _workKey, animate: false),
                    ),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdTrustedBy,
                      child: const TrustedBySection(),
                    ),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdAbout,
                      customAnimationBuilder: (_, controller) => AboutSection(
                        key: _aboutKey,
                        onMoreAboutTap: () => context.go(AppStrings.routeAbout),
                        animationController: controller,
                      ),
                      child: AboutSection(
                        key: _aboutKey,
                        onMoreAboutTap: () => context.go(AppStrings.routeAbout),
                        animate: false,
                      ),
                    ),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdTechStack,
                      child: const TechStackSection(),
                    ),
                    SectionAnimator(
                      sectionId: AppStrings.sectionIdServices,
                      customAnimationBuilder: (_, controller) =>
                          ServicesSection(
                            key: _servicesKey,
                            animationController: controller,
                          ),
                      child: ServicesSection(key: _servicesKey, animate: false),
                    ),
                    FooterSection(
                      key: _contactKey,
                      onGetInTouchTap: () =>
                          context.go(AppStrings.routeContact),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GlassNavbar(
            onLogoTap: () {
              _fadeOverlayThen(() {
                context.go(AppStrings.routeHome);
                url_fragment.setFragment('');
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            onWorkTap: () => _fadeOverlayThen(() {
              url_fragment.setFragment(AppStrings.fragmentWork);
              _scrollToSection(_workKey);
            }),
            onAboutTap: () =>
                _fadeOverlayThen(() => context.go(AppStrings.routeAbout)),
            onServicesTap: () {
              _fadeOverlayThen(() {
                url_fragment.setFragment(AppStrings.fragmentServices);
                _scrollToSection(_servicesKey);
              });
            },
            onContactTap: () =>
                _fadeOverlayThen(() => context.go(AppStrings.routeContact)),
            onResumeTap: () async {
              final Uri uri = Uri.parse(AppStrings.resumeUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
          IgnorePointer(
            ignoring: !_navFading,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 140),
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

class TrustedBySection extends StatelessWidget {
  const TrustedBySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(
        children: [
          Text(
            AppStrings.trustedByTitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 50,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: AppStrings.trustedByCompanies
                .map((name) => _companyLogo(name))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _companyLogo(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
