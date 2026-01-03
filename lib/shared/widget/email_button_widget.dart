import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class EmailButtonWidget extends StatelessWidget {
  const EmailButtonWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      key: EmailButtonKeys.widget,
      style: KButtonStyles.withoutStyle,
      onPressed: context.copyEmail,
      label: Text(
        key: EmailButtonKeys.text,
        KAppText.email,
        style: isDesk
            ? AppTextStyle.materialThemeTitleMedium
            : AppTextStyle.materialThemeTitleSmall,
      ),
      icon: KIcon.copy.copyWith(
        key: EmailButtonKeys.icon,
      ),
    );
  }
}
