import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    required this.isDesk,
    required this.routeName,
    required this.widgetKey,
    super.key,
  });
  final bool isDesk;
  final String routeName;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDesk ? Alignment.centerRight : Alignment.center,
      child: TextButton.icon(
        key: widgetKey,
        style: KButtonStyles.closeDialogButtonStyle,
        onPressed: () => context.goNamed(routeName),
        iconAlignment: IconAlignment.end,
        icon: const IconWidget(
          icon: KIcon.close,
          padding: KPadding.kPaddingSize4,
          background: AppColors.materialThemeWhite,
        ),
        label: Text(
          context.l10n.close,
          style: AppTextStyle.materialThemeTitleMediumNeutral,
        ),
      ),
    );
  }
}
