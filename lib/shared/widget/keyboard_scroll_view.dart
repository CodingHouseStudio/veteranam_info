import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
    return BlocListener<UrlCubit, UrlEnum?>(
      listener: (context, state) async {
        if (state != null) {
          context.dialog.showSnackBardTextDialog(
            state.value(context),
            duration: const Duration(milliseconds: 4000),
          );
          context.read<UrlCubit>().reset();
        }
      },
      child: PlatformEnumFlutter.isWebDesktop
          ? _KeyboardScrollViewWebDesk(
              widgetKey: widgetKey,
              slivers: slivers,
              semanticChildCount: semanticChildCount,
              physics: physics,
              scrollController: scrollController,
              maxHeight: maxHeight,
            )
          : Config.isWeb
              ? _body
              : BlocListener<AppVersionCubit, AppVersionState>(
                  listener: (context, state) =>
                      context.dialog.showMobUpdateAppDialog(
                    hasNewVersion: state.mobHasNewBuild,
                  ),
                  child: _body,
                ),
    );
  }

  Widget get _body => CustomScrollView(
        key: widgetKey,
        controller: scrollController,
        slivers: slivers,
        physics: physics,
        semanticChildCount: semanticChildCount,
      );
}

class _KeyboardScrollViewWebDesk extends StatefulWidget {
  const _KeyboardScrollViewWebDesk({
    required this.slivers,
    required this.semanticChildCount,
    required this.widgetKey,
    required this.maxHeight,
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
  State<_KeyboardScrollViewWebDesk> createState() =>
      _KeyboardScrollViewWebDeskState();
}

class _KeyboardScrollViewWebDeskState
    extends State<_KeyboardScrollViewWebDesk> {
  late FocusNode _focusNode;
  late ScrollController _controller;

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

  void _startScroll(LogicalKeyboardKey key) {
    const duration = Duration(milliseconds: 300);
    final step = widget.maxHeight * KSize.kPercentOfScreen;

    void scroll() {
      final offset = _controller.offset;
      switch (key) {
        case LogicalKeyboardKey.arrowDown:
          _controller.animateTo(
            offset + KSize.kArrowsStep,
            duration: duration,
            curve: Curves.linear,
          );
        case LogicalKeyboardKey.arrowUp:
          _controller.animateTo(
            offset - KSize.kArrowsStep,
            duration: duration,
            curve: Curves.linear,
          );
        case LogicalKeyboardKey.pageDown:
          _controller.animateTo(
            offset + step,
            duration: duration,
            curve: Curves.linear,
          );
        case LogicalKeyboardKey.pageUp:
          _controller.animateTo(
            offset - step,
            duration: duration,
            curve: Curves.linear,
          );
        case LogicalKeyboardKey.home:
          _controller.animateTo(
            0,
            duration: duration,
            curve: Curves.linear,
          );
        case LogicalKeyboardKey.end:
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
        setState(() {});
      },
      child: FocusableActionDetector(
        focusNode: _focusNode,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.arrowUp): ScrollUpIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): ScrollDownIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowLeft): ScrollLeftIntent(),
          // LogicalKeySet(LogicalKeyboardKey.arrowRight): ScrollRightIntent(),
          LogicalKeySet(LogicalKeyboardKey.pageDown): PageDownIntent(),
          LogicalKeySet(LogicalKeyboardKey.pageUp): PageUpIntent(),
          LogicalKeySet(LogicalKeyboardKey.home): HomeIntent(),
          LogicalKeySet(LogicalKeyboardKey.end): EndIntent(),
        },
        actions: {
          ScrollUpIntent: CallbackAction<ScrollUpIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.arrowUp);
              return;
            },
          ),
          ScrollDownIntent: CallbackAction<ScrollDownIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.arrowDown);
              return;
            },
          ),
          ScrollRightIntent: CallbackAction<ScrollRightIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.arrowDown);
              return;
            },
          ),
          ScrollLeftIntent: CallbackAction<ScrollLeftIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.arrowUp);
              return;
            },
          ),
          PageDownIntent: CallbackAction<PageDownIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.pageDown);
              return;
            },
          ),
          PageUpIntent: CallbackAction<PageUpIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.pageUp);
              return;
            },
          ),
          HomeIntent: CallbackAction<HomeIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.home);
              return;
            },
          ),
          EndIntent: CallbackAction<EndIntent>(
            onInvoke: (intent) {
              _startScroll(LogicalKeyboardKey.end);
              return;
            },
          ),
        },
        child: CustomScrollView(
          key: widget.widgetKey,
          controller: _controller,
          physics: widget.physics,
          slivers: widget.slivers,
        ),
      ),
    );
  }
}

class ScrollUpIntent extends Intent {}

class ScrollDownIntent extends Intent {}

class ScrollLeftIntent extends Intent {}

class ScrollRightIntent extends Intent {}

class PageDownIntent extends Intent {}

class PageUpIntent extends Intent {}

class HomeIntent extends Intent {}

class EndIntent extends Intent {}
