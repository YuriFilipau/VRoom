import 'dart:async';

import 'package:flutter/material.dart';

class StaggeredAppear extends StatefulWidget {
  const StaggeredAppear({
    required this.child,
    required this.index,
    this.step = const Duration(milliseconds: 70),
    this.duration = const Duration(milliseconds: 360),
    super.key,
  });

  final Widget child;
  final int index;
  final Duration step;
  final Duration duration;

  @override
  State<StaggeredAppear> createState() => _StaggeredAppearState();
}

class _StaggeredAppearState extends State<StaggeredAppear> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.step * widget.index, () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0, 0.05),
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
