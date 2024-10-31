import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class GetErrorDialogWidget extends StatelessWidget {
  const GetErrorDialogWidget({
    required this.onPressed,
    required this.error,
    super.key,
  });
  final void Function()? onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            error,
            key: KWidgetkeys.widget.dialogs.snackBarText,
            style: AppTextStyle.materialThemeTitleMediumNeutral,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    key: KWidgetkeys.widget.dialogs.failureButton,
                    style: KButtonStyles.whiteSnackBarButtonStyle,
                    onPressed: () {
                      onPressed?.call();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Text(
                      context.l10n.tryItAgain,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                  ),
                ),
              ),
              KSizedBox.kWidthSizedBox12,
              IconButtonWidget(
                icon: KIcon.close.copyWith(weight: 300),
                onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
                background: AppColors.materialThemeWhite,
                padding: KPadding.kPaddingSize10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
