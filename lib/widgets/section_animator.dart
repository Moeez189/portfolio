import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../providers/animation_provider.dart';

class SectionAnimator extends StatefulWidget {
  /// The content to animate.
  final Widget child;

  /// Unique ID for this section to track animation state.
  final String sectionId;

  /// Optional builder for custom animation.
  /// If null, a default Fade + Slide Up animation is used.
  /// The [controller] is provided to trigger the animation when visible.
  final Widget Function(Widget child, AnimationController controller)?
  customAnimationBuilder;

  const SectionAnimator({
    super.key,
    required this.child,
    required this.sectionId,
    this.customAnimationBuilder,
  });

  @override
  State<SectionAnimator> createState() => _SectionAnimatorState();
}

class _SectionAnimatorState extends State<SectionAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    // We create a controller but don't start it yet.
    // The duration here is a default base; flutter_animate effects can override/add to it.
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationProvider>(
      builder: (context, provider, _) {
        final hasAnimated = provider.hasAnimated(widget.sectionId);

        // If keeping the state is crucial (so it doesn't animate again if we scroll back up during same session BEFORE navigation),
        // we can respect the provider.
        if (hasAnimated) {
          return widget.child;
        }

        return VisibilityDetector(
          key: Key(widget.sectionId),
          onVisibilityChanged: (info) {
            if (!_hasTriggered && info.visibleFraction > 0.1) {
              _hasTriggered = true;
              _controller.forward();
              // Mark as animated in provider.
              // Note: This updates the global state.
              // If we want it to stay animated during just this scroll session but reset on reload,
              // Provider is good.
              provider.markAsAnimated(widget.sectionId);
            }
          },
          child: widget.customAnimationBuilder != null
              ? widget.customAnimationBuilder!(widget.child, _controller)
              : widget.child
                    .animate(controller: _controller, autoPlay: false)
                    .fadeIn(duration: 800.ms, curve: Curves.easeOutQuad)
                    .slideY(
                      begin: 0.2, // Slide up from slightly below
                      end: 0,
                      duration: 800.ms,
                      curve: Curves.easeOutCubic,
                    ),
        );
      },
    );
  }
}
