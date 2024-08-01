import 'package:flutter/material.dart';

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
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.scrollController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: (value) {
        if (_controller.position.outOfRange) {
          return;
        }
        final offset = _controller.offset;
        if (value.physicalKey.debugName == 'Arrow Down') {
          _controller.animateTo(
            offset + 100,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        }
        if (value.physicalKey.debugName == 'Arrow Up') {
          _controller.animateTo(
            offset - 100,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        }
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
