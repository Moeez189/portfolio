import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_strings.dart';
import '../utils/projects_repository.dart';

class ProjectsSection extends StatefulWidget {
  final AnimationController? animationController;
  final bool animate;

  const ProjectsSection({
    super.key,
    this.animationController,
    this.animate = true,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final Future<List<ProjectItem>> _projectsFuture;
  final ScrollController _projectsScrollController = ScrollController();
  int _currentProjectIndex = 0;

  @override
  void initState() {
    super.initState();
    _projectsFuture = ProjectsRepository.loadProjects();
  }

  @override
  void dispose() {
    _projectsScrollController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  double _cardWidth(bool isDesktop) => isDesktop ? 360 : 290;

  double _cardExtent(bool isDesktop) => _cardWidth(isDesktop) + 16;

  void _updateCurrentIndexFromScroll(
    ScrollMetrics metrics,
    int itemCount,
    bool isDesktop,
  ) {
    if (itemCount <= 0) return;
    const edgeTolerance = 8.0;

    final double pixels = metrics.pixels;
    final double min = metrics.minScrollExtent;
    final double max = metrics.maxScrollExtent;

    final int nextIndex;
    if (pixels <= min + edgeTolerance) {
      nextIndex = 0;
    } else if (pixels >= max - edgeTolerance) {
      nextIndex = itemCount - 1;
    } else {
      final extent = _cardExtent(isDesktop);
      final estimated = (pixels / extent).round();
      nextIndex = estimated.clamp(0, itemCount - 1);
    }

    if (nextIndex != _currentProjectIndex) {
      setState(() => _currentProjectIndex = nextIndex);
    }
  }

  void _goToIndex({
    required int index,
    required int itemCount,
    required bool isDesktop,
  }) {
    if (!_projectsScrollController.hasClients || itemCount <= 0) return;
    final int targetIndex = index.clamp(0, itemCount - 1);
    final position = _projectsScrollController.position;
    final targetOffset = (targetIndex * _cardExtent(isDesktop)).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    setState(() => _currentProjectIndex = targetIndex);
    _projectsScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToNextLoop({
    required int itemCount,
    required bool isDesktop,
    required int activeIndex,
  }) {
    if (itemCount <= 0) return;
    final int targetIndex = (activeIndex + 1) % itemCount;
    _goToIndex(index: targetIndex, itemCount: itemCount, isDesktop: isDesktop);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    final double? target = widget.animate ? null : 1.0;
    final bool autoPlay =
        widget.animate && (widget.animationController == null);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 16,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    AppStrings.projectsSectionTitle,
                    style: TextStyle(
                      fontSize: isDesktop ? 42 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              )
              .animate(
                controller: widget.animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(duration: 800.ms)
              .slideY(begin: 0.1, duration: 800.ms),
          const SizedBox(height: 16),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  AppStrings.projectsSectionDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              )
              .animate(
                controller: widget.animationController,
                autoPlay: autoPlay,
                target: target,
              )
              .fadeIn(delay: 150.ms, duration: 700.ms)
              .slideY(begin: 0.1, duration: 700.ms),
          const SizedBox(height: 36),
          FutureBuilder<List<ProjectItem>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return _buildInfoMessage(AppStrings.projectsLoading, isDesktop);
              }

              if (snapshot.hasError) {
                return _buildInfoMessage(
                  AppStrings.projectsLoadError,
                  isDesktop,
                );
              }

              final projects = snapshot.data ?? const <ProjectItem>[];
              if (projects.isEmpty) {
                return _buildInfoMessage(
                  AppStrings.projectsLoadError,
                  isDesktop,
                );
              }

              final int activeIndex = _currentProjectIndex.clamp(
                0,
                projects.length - 1,
              );
              final bool showBack = activeIndex > 0;
              final bool showForward = projects.length > 1;

              final double listHeight = isDesktop ? 340 : 315;

              return SizedBox(
                height: listHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.axis == Axis.horizontal) {
                          _updateCurrentIndexFromScroll(
                            notification.metrics,
                            projects.length,
                            isDesktop,
                          );
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: _projectsScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.symmetric(
                          vertical: isDesktop ? 14 : 10,
                          horizontal: 6,
                        ),
                        itemCount: projects.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return _buildProjectCard(
                            project: projects[index],
                            isDesktop: isDesktop,
                            index: index,
                          );
                        },
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      left: showBack ? 4 : -64,
                      top: listHeight / 2 - 26,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity: showBack ? 1 : 0,
                        child: _ProjectsFloatingNavButton(
                          icon: Icons.arrow_back_rounded,
                          tooltip: 'Back',
                          onTap: () => _goToIndex(
                            index: activeIndex - 1,
                            itemCount: projects.length,
                            isDesktop: isDesktop,
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      right: showForward ? 4 : -64,
                      top: listHeight / 2 - 26,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity: showForward ? 1 : 0,
                        child: _ProjectsFloatingNavButton(
                          icon: Icons.arrow_forward_rounded,
                          tooltip: 'Next',
                          onTap: () => _goToNextLoop(
                            itemCount: projects.length,
                            isDesktop: isDesktop,
                            activeIndex: activeIndex,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoMessage(String message, bool isDesktop) {
    return SizedBox(
      height: isDesktop ? 220 : 180,
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard({
    required ProjectItem project,
    required bool isDesktop,
    required int index,
  }) {
    final bool clickableCard = project.hasSinglePlatform;
    final double cardWidth = isDesktop ? 360 : 290;
    return _InteractiveProjectCard(
          project: project,
          width: cardWidth,
          clickableCard: clickableCard,
          isDesktop: isDesktop,
          onCardTap: clickableCard && project.singlePlatformLink != null
              ? () => _openUrl(project.singlePlatformLink!)
              : null,
          onAndroidTap: project.hasAndroid
              ? () => _openUrl(project.androidLink)
              : null,
          onIosTap: project.hasIos ? () => _openUrl(project.iosLink) : null,
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 90 * index),
          duration: 500.ms,
        )
        .slideX(begin: 0.08, duration: 450.ms, curve: Curves.easeOut);
  }
}

class _ProjectsFloatingNavButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ProjectsFloatingNavButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_ProjectsFloatingNavButton> createState() =>
      _ProjectsFloatingNavButtonState();
}

class _ProjectsFloatingNavButtonState
    extends State<_ProjectsFloatingNavButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
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
            scale: _pressed ? 0.94 : (_hovered ? 1.04 : 1.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 170),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _hovered
                    ? const Color(0xFF1A1A1A)
                    : Colors.white.withValues(alpha: 0.96),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _hovered
                      ? const Color(0xFF1A1A1A)
                      : Colors.grey.withValues(alpha: 0.25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: _hovered ? 0.18 : 0.1,
                    ),
                    blurRadius: _hovered ? 20 : 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                size: 22,
                color: _hovered ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InteractiveProjectCard extends StatefulWidget {
  final ProjectItem project;
  final double width;
  final bool clickableCard;
  final bool isDesktop;
  final VoidCallback? onCardTap;
  final VoidCallback? onAndroidTap;
  final VoidCallback? onIosTap;

  const _InteractiveProjectCard({
    required this.project,
    required this.width,
    required this.clickableCard,
    required this.isDesktop,
    this.onCardTap,
    this.onAndroidTap,
    this.onIosTap,
  });

  @override
  State<_InteractiveProjectCard> createState() =>
      _InteractiveProjectCardState();
}

class _InteractiveProjectCardState extends State<_InteractiveProjectCard> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bool enableHover = widget.isDesktop;
    final bool hovered = enableHover && _hovered;
    final bool clickable = widget.onCardTap != null;

    return MouseRegion(
      cursor: clickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onCardTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          scale: _pressed
              ? 0.985
              : hovered
              ? 1.015
              : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 210),
            curve: Curves.easeOutCubic,
            width: widget.width,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: hovered
                    ? const Color(0xFF1A1A1A).withValues(alpha: 0.22)
                    : Colors.grey.withValues(alpha: 0.18),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.98),
                  hovered
                      ? const Color(0xFFFEEC81).withValues(alpha: 0.18)
                      : Colors.white.withValues(alpha: 0.94),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: hovered ? 0.14 : 0.06),
                  blurRadius: hovered ? 32 : 24,
                  offset: Offset(0, hovered ? 18 : 12),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -18,
                  right: -18,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: hovered ? 1 : 0,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFEEC81).withValues(alpha: 0.35),
                            const Color(0xFFFEEC81).withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.name,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                        AnimatedSlide(
                          duration: const Duration(milliseconds: 180),
                          offset: hovered
                              ? Offset.zero
                              : const Offset(-0.15, 0),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 180),
                            opacity: hovered ? 1 : 0.55,
                            child: Icon(
                              Icons.north_east_rounded,
                              size: 18,
                              color: const Color(
                                0xFF1A1A1A,
                              ).withValues(alpha: hovered ? 0.9 : 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (widget.onAndroidTap != null)
                          _PlatformButton(
                            icon: Icons.android,
                            label: AppStrings.openAndroid,
                            onTap: widget.onAndroidTap!,
                          ),
                        if (widget.onAndroidTap != null &&
                            widget.onIosTap != null)
                          const SizedBox(width: 10),
                        if (widget.onIosTap != null)
                          _PlatformButton(
                            icon: Icons.apple,
                            label: AppStrings.openIos,
                            onTap: widget.onIosTap!,
                          ),
                        const Spacer(),
                        if (widget.clickableCard)
                          Text(
                            AppStrings.singlePlatformTapHint,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlatformButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PlatformButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_PlatformButton> createState() => _PlatformButtonState();
}

class _PlatformButtonState extends State<_PlatformButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _hovered
                    ? const Color(0xFF1A1A1A).withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                size: 20,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
