import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class PopupMenuItemWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuItemWidget({
    required this.child,
    this.value,
    this.padding = const EdgeInsets.all(KPadding.kPaddingSize16),
    this.onTap,
    this.enabled = true,
    this.height = kMinInteractiveDimension,
    super.key,
  });

  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  final EdgeInsets padding;

  @override
  final double height;

  final Widget child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  PopupMenuItemState<T, PopupMenuItemWidget<T>> createState() =>
      PopupMenuItemState<T, PopupMenuItemWidget<T>>();
}

class PopupMenuItemState<T, W extends PopupMenuItemWidget<T>> extends State<W> {
  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: TextButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(widget.padding),
            alignment: Alignment.centerLeft,
          ),
          onPressed: widget.enabled ? handleTap : null,
          child: ListTileTheme.merge(
            contentPadding: EdgeInsets.zero,
            titleTextStyle: AppTextStyle.materialThemeTitleLarge,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
