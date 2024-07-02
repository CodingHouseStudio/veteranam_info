import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButtonWidget(
          key: KWidgetkeys.widget.reportDialog.button,
          onPressed: () => context.dialog.showReportDialog(isDesk: isDesk),
          icon: KIcon.brightnessAlert,
          padding: KPadding.kPaddingSize12,
          background: AppColors.materialThemeWhite,
        ),
        KSizedBox.kHeightSizedBox2,
        Text(
          context.l10n.complaint,
          style: AppTextStyle.materialThemeLabelSmall,
        ),
      ],
    );
  }
}
