import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    required this.isSelected,
    required this.onChanged,
    super.key,
  });
  final bool isSelected;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: KWidgetkeys.widget.switchKeys.widget,
      value: isSelected,
      onChanged: onChanged,
    );
  }
}
