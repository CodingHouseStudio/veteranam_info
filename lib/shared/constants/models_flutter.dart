import 'package:flutter/widgets.dart' show Key, VoidCallback, Widget;

class DropDownItem {
  DropDownItem({
    required this.text,
    required this.action,
    required this.key,
    this.icon,
  });

  final String text;
  final VoidCallback? action;
  final Widget? icon;
  final Key key;
}
