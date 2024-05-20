import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CheckPointSingleWidget extends StatefulWidget {
  const CheckPointSingleWidget({
    required this.onChanged,
    super.key,
  });
  final void Function()? onChanged;

  @override
  State<CheckPointSingleWidget> createState() => _CheckPointSingleWidgetState();
}

class _CheckPointSingleWidgetState extends State<CheckPointSingleWidget> {
  late bool isCheck;

  @override
  void initState() {
    super.initState();
    isCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      isSelected: isCheck,
      onPressed: () {
        setState(() {
          isCheck = !isCheck;
        });
        if (widget.onChanged != null) {
          widget.onChanged!;
        }
      },
      icon: Container(
        key: KWidgetkeys.widget.checkPointSingle.widget,
        decoration: context.widgetTheme.boxCheckPoint.copyWith(
          color: isCheck ? null : context.color.background,
        ),
        child: isCheck
            ? KIcon.check.setIconKey(
                KWidgetkeys.widget.checkPointSingle.icon,
              )
            : const SizedBox(
                width: KSize.kIconSize,
                height: KSize.kIconSize,
              ),
      ),
    );
  }
}
