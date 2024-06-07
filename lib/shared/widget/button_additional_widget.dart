import 'package:flutter/material.dart';
import 'package:kozak/l10n/l10n.dart';
import 'package:kozak/shared/constants/constants.dart';

class ButtonAdditionalWidget extends StatelessWidget {
  const ButtonAdditionalWidget({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(KSize.kRadius32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              child: KIcon.google,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KPadding.kPaddingSize8,
                right: KPadding.kPaddingSize16,
              ),
              child: Text(
                context.l10n.google,
                style: AppTextStyle.text14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
