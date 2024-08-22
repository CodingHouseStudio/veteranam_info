import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class SwitchWidgetWithoutBloc extends StatefulWidget {
  const SwitchWidgetWithoutBloc({super.key});

  @override
  State<SwitchWidgetWithoutBloc> createState() =>
      _SwitchWidgetWithoutBlocState();
}

class _SwitchWidgetWithoutBlocState extends State<SwitchWidgetWithoutBloc> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchWidget(
      // key: KWidgetkeys.widget.switchKeys.widget,
      // thumbColor: MaterialStatePropertyAll(
      // isSelected ? AppColors.black : AppColors.white,
      // ),
      // trackColor: const MaterialStatePropertyAll(AppColors.widgetBackground),
      isSelected: isSelected,
      // trackOutlineColor:
      //     const MaterialStatePropertyAll(AppColors.widgetBackground),
      onChanged: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}
