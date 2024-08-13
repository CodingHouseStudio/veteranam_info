import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veteranam/shared/shared.dart';

class KeyboardScrollView extends StatelessWidget {
  const KeyboardScrollView({
    required this.slivers,
    required this.semanticChildCount,
    required this.widgetKey,
    required this.maxHeight,
    super.key,
    this.physics,
    this.scrollController,
  });
  final List<Widget> slivers;
  final int semanticChildCount;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Key widgetKey;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    if (KPlatformConstants.isWebDesktop) {
      return _KeyboardScrollViewWebDesk(
        widgetKey: widgetKey,
        slivers: slivers,
        semanticChildCount: semanticChildCount,
        physics: physics,
        scrollController: scrollController,
        maxHeight: maxHeight,
      );
    } else {
      return CustomScrollView(
        key: widgetKey,
        controller: scrollController,
        slivers: slivers,
        physics: physics,
        semanticChildCount: semanticChildCount,
      );
    }
  }
}

class _KeyboardScrollViewWebDesk extends StatefulWidget {
  const _KeyboardScrollViewWebDesk({
    required this.slivers,
    required this.semanticChildCount,
    required this.physics,
    required this.scrollController,
    required this.widgetKey,
    required this.maxHeight,
  });

  final List<Widget> slivers;
  final int semanticChildCount;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Key widgetKey;
  final double maxHeight;

  @override
  State<_KeyboardScrollViewWebDesk> createState() =>
      _KeyboardScrollViewWebDeskState();
}

class _KeyboardScrollViewWebDeskState
    extends State<_KeyboardScrollViewWebDesk> {
  late ScrollController _controller;
  Timer? _timer;

  @override
  void initState() {
    _controller = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (widget.scrollController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _startScroll(PhysicalKeyboardKey key) {
    const duration = Duration(milliseconds: 300);
    final step = widget.maxHeight * KSize.kPercentOfScreen;

    void scroll() {
      final offset = _controller.offset;
      switch (key) {
        case PhysicalKeyboardKey.arrowDown:
          _controller.animateTo(
            offset + KSize.kArrowsStep,
            duration: duration,
            curve: Curves.linear,
          );
        case PhysicalKeyboardKey.arrowUp:
          _controller.animateTo(
            offset - KSize.kArrowsStep,
            duration: duration,
            curve: Curves.linear,
          );
        case PhysicalKeyboardKey.pageDown:
        case PhysicalKeyboardKey.space:
          _controller.animateTo(
            offset + step,
            duration: duration,
            curve: Curves.linear,
          );
        case PhysicalKeyboardKey.pageUp:
          _controller.animateTo(
            offset - step,
            duration: duration,
            curve: Curves.linear,
          );
        case PhysicalKeyboardKey.home:
          _controller.animateTo(
            0,
            duration: duration,
            curve: Curves.linear,
          );
        case PhysicalKeyboardKey.end:
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: duration,
            curve: Curves.linear,
          );
        default:
          break;
      }
    }

    scroll();
    _timer = Timer.periodic(duration, (timer) => scroll());
  }

  bool isScrollingKey(PhysicalKeyboardKey key) => [
        PhysicalKeyboardKey.arrowDown,
        PhysicalKeyboardKey.arrowUp,
        PhysicalKeyboardKey.pageDown,
        PhysicalKeyboardKey.pageUp,
        PhysicalKeyboardKey.space,
        PhysicalKeyboardKey.home,
        PhysicalKeyboardKey.end,
      ].contains(key);

  void _stopScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (isScrollingKey(event.physicalKey)) {
          if (event is KeyDownEvent) {
            if (_timer == null) {
              _startScroll(event.physicalKey);
            }
            return KeyEventResult.handled;
          } else if (event is KeyUpEvent) {
            _stopScroll();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: CustomScrollView(
        key: widget.widgetKey,
        controller: _controller,
        slivers: widget.slivers,
        physics: widget.physics,
        semanticChildCount: widget.semanticChildCount,
      ),
    );
  }
}
