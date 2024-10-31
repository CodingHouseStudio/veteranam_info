import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterResetButton extends StatelessWidget {
  const AdvancedFilterResetButton({
    required this.isDesk,
    super.key,
    this.resetEvent,
  });
  final bool isDesk;
  final void Function()? resetEvent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        key: KWidgetkeys.screen.discounts.advancedFilterResetButton,
        style: KButtonStyles.borderBlackButtonStyle.copyWith(
          padding: isDesk
              ? null
              : const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize8,
                    horizontal: KPadding.kPaddingSize24,
                  ),
                ),
        ),
        onPressed: resetEvent,
        child: Text(
          context.l10n.resetAll,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
      ),
    );
  }
}
