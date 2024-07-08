import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    required this.isDesk,
    required this.cardEnum,
    required this.afterEvent,
    super.key,
  });
  final bool isDesk;
  final CardEnum cardEnum;
  final void Function()? afterEvent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButtonWidget(
          key: KWidgetkeys.widget.reportDialog.button,
          onPressed: () => context.dialog.showReportDialog(
            isDesk: isDesk,
            cardEnum: cardEnum,
            afterEvent: afterEvent,
          ),
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
