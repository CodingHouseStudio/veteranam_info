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
    return Container(
      key: KWidgetkeys.widget.checkPointSingle.widget,
      decoration: BoxDecoration(
        color: isCheck
            ? Theme.of(context).colorScheme.onSecondary
            : Colors.transparent,
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: KSize.kPixel3,
        ),
        borderRadius: KBorderRadius.kBorderRadius8,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isCheck = !isCheck;
          });
          if (widget.onChanged != null) {
            widget.onChanged;
          }
        },
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
