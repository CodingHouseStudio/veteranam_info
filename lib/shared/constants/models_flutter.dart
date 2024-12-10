import 'package:flutter/widgets.dart' show Key, VoidCallback, Widget;

class DropDownItem {
  DropDownItem({
    required this.text,
    required this.event,
    required this.key,
    this.icon,
  });

  final String text;
  final VoidCallback? event;
  final Key? key;
  final Widget? icon;
}
