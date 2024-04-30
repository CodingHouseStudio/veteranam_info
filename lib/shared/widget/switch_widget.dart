import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: KWidgetkeys.widget.switchKeys.widget,
      // thumbColor: MaterialStatePropertyAll(
      // isSelected ? AppColors.black : AppColors.white,
      // ),
      // trackColor: const MaterialStatePropertyAll(AppColors.widgetBackground),
      value: isSelected,
      // trackOutlineColor:
      //     const MaterialStatePropertyAll(AppColors.widgetBackground),
      onChanged: (value) {
        setState(() {
          isSelected = value;
        });
      },
    );
  }
}
