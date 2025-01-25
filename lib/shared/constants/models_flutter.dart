import 'package:flutter/widgets.dart' show Key, VoidCallback, Widget;

class PopupMenuCustomItem<T> {
  PopupMenuCustomItem({
    required this.value,
    required this.text,
    required this.event,
    required this.key,
    this.enabled = true,
    this.icon,
  });

  final String text;
  final VoidCallback? event;
  final Key? key;
  final bool enabled;
  final T value;
  final Widget? icon;
}
