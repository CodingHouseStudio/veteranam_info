import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({
    required this.onChanged,
    required this.isCheck,
    super.key,
  });
  final void Function() onChanged;
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.checkPoint.widget,
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
        onTap: onChanged,
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
