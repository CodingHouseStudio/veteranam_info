import 'package:flutter/widgets.dart' show Key, VoidCallback;

class DropDownItem {
  DropDownItem({
    required this.text,
    required this.event,
    required this.key,
  });

  final String text;
  final VoidCallback? event;
  final Key? key;
}
