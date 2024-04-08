import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CheckPointWidget extends StatefulWidget {
  const CheckPointWidget({required this.onChanged, super.key});
  final void Function({required bool isCheck}) onChanged;

  @override
  State<CheckPointWidget> createState() => _CheckPointWidgetState();
}

class _CheckPointWidgetState extends State<CheckPointWidget> {
  late bool isCheck;
  @override
  void initState() {
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.checkPoint.widget,
      decoration: BoxDecoration(
        color: isCheck
            ? AppColors.transparent
            : AppColors.widgetBackground.withOpacity(
                KSize.kOpacityHalf,
              ),
        border:
            Border.all(color: AppColors.widgetBackground, width: KSize.kPixel3),
        borderRadius: KBorderRadius.kBorderRadius8,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isCheck = !isCheck;
          });
          widget.onChanged(isCheck: isCheck);
        },
        child: isCheck
            ? KIcon.check.setIconKey(
                KWidgetkeys.widget.checkPoint.icon,
              )
            : const SizedBox(
                width: KSize.kIconSize,
                height: KSize.kIconSize,
              ),
      ),
    );
  }
}
