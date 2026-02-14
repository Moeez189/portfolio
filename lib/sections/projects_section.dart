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

  @override
  void initState() {
    super.initState();
    _projectsFuture = ProjectsRepository.loadProjects();
  }

  Future<void> _openUrl(String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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

              return SizedBox(
                height: isDesktop ? 300 : 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
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

    final card =
        AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: cardWidth,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.18),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.description,
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
                      if (project.hasAndroid)
                        _PlatformButton(
                          icon: Icons.android,
                          label: AppStrings.openAndroid,
                          onTap: () => _openUrl(project.androidLink),
                        ),
                      if (project.hasAndroid && project.hasIos)
                        const SizedBox(width: 10),
                      if (project.hasIos)
                        _PlatformButton(
                          icon: Icons.apple,
                          label: AppStrings.openIos,
                          onTap: () => _openUrl(project.iosLink),
                        ),
                      const Spacer(),
                      if (clickableCard)
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
            )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 90 * index),
              duration: 500.ms,
            )
            .slideX(begin: 0.08, duration: 450.ms, curve: Curves.easeOut);

    return MouseRegion(
      cursor: clickableCard
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: clickableCard && project.singlePlatformLink != null
            ? () => _openUrl(project.singlePlatformLink!)
            : null,
        child: card,
      ),
    );
  }
}

class _PlatformButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PlatformButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
          ),
        ),
      ),
    );
  }
}
