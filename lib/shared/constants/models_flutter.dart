import 'package:flutter/widgets.dart'
    show EdgeInsets, Key, VoidCallback, Widget;

class DropDownItem<T> {
  DropDownItem({
    required this.value,
    required this.text,
    required this.event,
    required this.key,
    this.enabled = true,
    this.icon,
    this.padding,
  });

  final String text;
  final VoidCallback? event;
  final Key? key;
  final bool enabled;
  final T value;
  final Widget? icon;
  final EdgeInsets? padding;
}
