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
      decoration: KWidgetTheme.boxCheckPoint.copyWith(
        color: isCheck ? null : AppColors.materialThemeWhite,
      ),
      child: InkWell(
        onTap: onChanged,
        child: isCheck
            ? KIcon.check.copyWith(
                key: KWidgetkeys.widget.checkPoint.icon,
              )
            : const SizedBox(
                width: KSize.kIconSize,
                height: KSize.kIconSize,
              ),
      ),
    );
  }
}
