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
    return TextButton(
      key: DiscountsFilterKeys.resetButton,
      style: isDesk
          ? KButtonStyles.borderBlackButtonStyle
          : KButtonStyles.borderBlackButtonAdvancedFilterStyle,
      onPressed: resetEvent,
      child: Text(
        context.l10n.resetAll,
        style: AppTextStyle.materialThemeTitleMedium,
      ),
    );
  }
}
