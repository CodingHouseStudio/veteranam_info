import 'package:flutter/widgets.dart' show Key, VoidCallback;

class DropDownItem {
  DropDownItem({
    required this.text,
    required this.action,
    required this.key,
  });

  final String text;
  final VoidCallback? action;
  final Key? key;
}
