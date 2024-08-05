import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veteranam/shared/shared.dart';

class KeyboardScrollView extends StatelessWidget {
  const KeyboardScrollView({
    required this.slivers,
    required this.semanticChildCount,
    required this.widgetKey,
    super.key,
    this.physics,
    this.scrollController,
  });
  final List<Widget> slivers;
  final int semanticChildCount;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    if (KPlatformConstants.isWebDesktop) {
      return _KeyboardScrollViewWebDesk(
        widgetKey: widgetKey,
        slivers: slivers,
        semanticChildCount: semanticChildCount,
        physics: physics,
        scrollController: scrollController,
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
  });

  final List<Widget> slivers;
  final int semanticChildCount;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Key widgetKey;

  @override
  State<_KeyboardScrollViewWebDesk> createState() =>
      _KeyboardScrollViewWebDeskState();
}

class _KeyboardScrollViewWebDeskState
    extends State<_KeyboardScrollViewWebDesk> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent) {
          final offset = _controller.offset;

          switch (event.physicalKey) {
            case PhysicalKeyboardKey.arrowDown:
              _controller.animateTo(
                offset + 100,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.arrowUp:
              _controller.animateTo(
                offset - 100,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.pageDown:
              _controller.animateTo(
                offset + 600,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.pageUp:
              _controller.animateTo(
                offset - 600,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.space:
              _controller.animateTo(
                offset + 600,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.home:
              _controller.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            case PhysicalKeyboardKey.end:
              _controller.animateTo(
                _controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            default:
              return KeyEventResult.ignored;
          }
          return KeyEventResult.handled;
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
