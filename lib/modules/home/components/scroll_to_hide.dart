import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollHide extends StatefulWidget {
  const ScrollHide(
      {super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 200),
      required this.scrollController});

  final Widget child;
  final Duration duration;
  final ScrollController scrollController;

  @override
  State<ScrollHide> createState() => _ScrollHideState();
}

class _ScrollHideState extends State<ScrollHide> {
  bool _isVisible = true;

  @override
  void initState() {
    widget.scrollController.addListener(listener);
    super.initState();
  }

  void listener() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      showBootomNav();
    } else if (direction == ScrollDirection.reverse) {
      hideBottomNav();
    }
  }

  void showBootomNav() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void hideBottomNav() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: _isVisible ? kBottomNavigationBarHeight : 0,
      child: Wrap(children: [widget.child]),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listener);
    widget.scrollController.dispose();
    super.dispose();
  }
}
