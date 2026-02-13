import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final bool active;
  final TextStyle style;
  final Duration duration;

  const TypewriterText({
    super.key,
    required this.text,
    required this.active,
    required this.style,
    this.duration = const Duration(milliseconds: 320),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<int> _count;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _count = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text) {
      _count = StepTween(
        begin: 0,
        end: widget.text.length,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    }

    if (!oldWidget.active && widget.active) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      return Text(widget.text, style: widget.style);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: Text(widget.text, style: widget.style)),
        AnimatedBuilder(
          animation: _count,
          builder: (context, child) {
            final visible = widget.text.substring(0, _count.value);
            return Text(visible, style: widget.style);
          },
        ),
      ],
    );
  }
}
