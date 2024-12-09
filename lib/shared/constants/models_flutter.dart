import 'package:flutter/widgets.dart' show Key, VoidCallback;

class DropDownItem<T> {
  DropDownItem({
    required this.value,
    required this.text,
    required this.event,
    required this.key,
    this.enabled = true,
  });

  final String text;
  final VoidCallback? event;
  final Key? key;
  final bool enabled;
  final T value;
}
