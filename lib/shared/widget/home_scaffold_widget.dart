import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class HomeScaffoldWidget extends StatelessWidget {
  const HomeScaffoldWidget({
    required this.childWidgetsFunction,
    super.key,
  });
  final List<Widget> Function({required bool isDesk}) childWidgetsFunction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final childWidgets = childWidgetsFunction(isDesk: isDesk)
          ..add(
            FooterWidget(
              isDesk: isDesk,
            ),
          );
        return Scaffold(
          body: BlocBuilder<ScrollCubit, ScrollController>(
            builder: (context, _) {
              return Padding(
                padding: EdgeInsets.only(
                  left: isDesk
                      ? KPadding.kPaddingSize90
                      : KPadding.kPaddingSize16,
                  right: isDesk
                      ? KPadding.kPaddingSize90
                      : KPadding.kPaddingSize16,
                  bottom: isDesk
                      ? KPadding.kPaddingSize40
                      : KPadding.kPaddingSize24,
                ),
                child: CustomScrollView(
                  key: KWidgetkeys.widget.shellRoute.scroll,
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: HomeNawbarWidget(isDesk: isDesk),
                    ),
                    SliverList(
                      delegate: _HomeItemWidget(
                        childWidgets: childWidgets,
                        isDesk: isDesk,
                      ),
                    ),
                  ],
                  controller: _,
                  semanticChildCount: childWidgets.length,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _HomeItemWidget extends SliverChildDelegate {
  const _HomeItemWidget({
    required this.childWidgets,
    required this.isDesk,
    // ignore: unused_element
    this.addAutomaticKeepAlives = true,
    // ignore: unused_element
    this.addRepaintBoundaries = true,
    // ignore: unused_element
    this.addSemanticIndexes = true,
    // ignore: unused_element
    this.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    // ignore: unused_element
    this.semanticIndexOffset = 0,
  });
  final bool isDesk;
  final List<Widget> childWidgets;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addAutomaticKeepAlives}
  final bool addAutomaticKeepAlives;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addRepaintBoundaries}
  final bool addRepaintBoundaries;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.addSemanticIndexes}
  final bool addSemanticIndexes;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.semanticIndexOffset}
  final int semanticIndexOffset;

  /// {@macro flutter.widgets.SliverChildBuilderDelegate.semanticIndexCallback}
  final SemanticIndexCallback semanticIndexCallback;

  //Rebuild screen only when isDesk value change
  @override
  bool shouldRebuild(covariant SliverChildDelegate oldDelegate) =>
      oldDelegate is _HomeItemWidget && isDesk != oldDelegate.isDesk;

  @override
  Widget? build(BuildContext context, int index) {
    if (index < 0 || index >= childWidgets.length) {
      return null;
    }
    var child = childWidgets[index];
    final Key? key = child.key != null ? _SaltedValueKey(child.key!) : null;
    if (addRepaintBoundaries) {
      child = RepaintBoundary(child: child);
    }
    if (addSemanticIndexes) {
      final semanticIndex = semanticIndexCallback(child, index);
      if (semanticIndex != null) {
        child = IndexedSemantics(
          index: semanticIndex + semanticIndexOffset,
          child: child,
        );
      }
    }
    if (addAutomaticKeepAlives) {
      child = AutomaticKeepAlive(child: _SelectionKeepAlive(child: child));
    }

    return KeyedSubtree(key: key, child: child);
  }
}

class _SaltedValueKey extends ValueKey<Key> {
  const _SaltedValueKey(super.value);
}

int _kDefaultSemanticIndexCallback(Widget _, int localIndex) => localIndex;

class _SelectionKeepAlive extends StatefulWidget {
  /// Creates a widget that listens to [KeepAliveNotification]s and maintains a
  /// [KeepAlive] widget appropriately.
  const _SelectionKeepAlive({
    required this.child,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  State<_SelectionKeepAlive> createState() => _SelectionKeepAliveState();
}

class _SelectionKeepAliveState extends State<_SelectionKeepAlive>
    with AutomaticKeepAliveClientMixin
    implements SelectionRegistrar {
  Set<Selectable>? _selectablesWithSelections;
  Map<Selectable, VoidCallback>? _selectableAttachments;
  SelectionRegistrar? _registrar;

  @override
  bool get wantKeepAlive => _wantKeepAlive;
  bool _wantKeepAlive = false;
  set wantKeepAlive(bool value) {
    if (_wantKeepAlive != value) {
      _wantKeepAlive = value;
      updateKeepAlive();
    }
  }

  VoidCallback listensTo(Selectable selectable) {
    return () {
      if (selectable.value.hasSelection) {
        _updateSelectablesWithSelections(selectable, add: true);
      } else {
        _updateSelectablesWithSelections(selectable, add: false);
      }
    };
  }

  void _updateSelectablesWithSelections(
    Selectable selectable, {
    required bool add,
  }) {
    if (add) {
      // assert(selectable.value.hasSelection);
      _selectablesWithSelections ??= <Selectable>{};
      _selectablesWithSelections!.add(selectable);
    } else {
      _selectablesWithSelections?.remove(selectable);
    }
    wantKeepAlive = _selectablesWithSelections?.isNotEmpty ?? false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newRegistrar = SelectionContainer.maybeOf(context);
    if (_registrar != newRegistrar) {
      if (_registrar != null) {
        _selectableAttachments?.keys.forEach(_registrar!.remove);
      }
      _registrar = newRegistrar;
      if (_registrar != null) {
        _selectableAttachments?.keys.forEach(_registrar!.add);
      }
    }
  }

  @override
  void add(Selectable selectable) {
    final attachment = listensTo(selectable);
    selectable.addListener(attachment);
    _selectableAttachments ??= <Selectable, VoidCallback>{};
    _selectableAttachments![selectable] = attachment;
    _registrar!.add(selectable);
    if (selectable.value.hasSelection) {
      _updateSelectablesWithSelections(selectable, add: true);
    }
  }

  @override
  void remove(Selectable selectable) {
    if (_selectableAttachments == null) {
      return;
    }
    // assert(_selectableAttachments!.containsKey(selectable));
    final attachment = _selectableAttachments!.remove(selectable)!;
    selectable.removeListener(attachment);
    _registrar!.remove(selectable);
    _updateSelectablesWithSelections(selectable, add: false);
  }

  @override
  void dispose() {
    if (_selectableAttachments != null) {
      for (final selectable in _selectableAttachments!.keys) {
        _registrar!.remove(selectable);
        selectable.removeListener(_selectableAttachments![selectable]!);
      }
      _selectableAttachments = null;
    }
    _selectablesWithSelections = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_registrar == null) {
      return widget.child;
    }
    return SelectionRegistrarScope(
      registrar: this,
      child: widget.child,
    );
  }
}
