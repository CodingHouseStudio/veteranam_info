import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardScrollView extends StatefulWidget {
  const KeyboardScrollView({
    required this.slivers,
    required this.semanticChildCount,
    this.physics,
    this.scrollController,
    super.key,
  });

  final List<Widget> slivers;
  final int semanticChildCount;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  @override
  KeyboardScrollViewState createState() => KeyboardScrollViewState();
}

class KeyboardScrollViewState extends State<KeyboardScrollView> {
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
        controller: _controller,
        slivers: widget.slivers,
        physics: widget.physics,
        semanticChildCount: widget.semanticChildCount,
      ),
    );
  }
}
