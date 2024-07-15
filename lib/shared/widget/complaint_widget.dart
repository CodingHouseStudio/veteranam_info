import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    required this.isDesk,
    required this.cardEnum,
    required this.afterEvent,
    required this.cardId,
    super.key,
  });
  final bool isDesk;
  final CardEnum cardEnum;
  final void Function()? afterEvent;
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.dialog.showReportDialog(
        isDesk: isDesk,
        cardEnum: cardEnum,
        afterEvent: afterEvent,
        cardId: cardId,
      ),
      child: Column(
        children: [
          KSizedBox.kHeightSizedBox10,
          IconButtonWidget(
            key: KWidgetkeys.widget.reportDialog.button,
            onPressed: () => context.dialog.showReportDialog(
              isDesk: isDesk,
              cardEnum: cardEnum,
              afterEvent: afterEvent,
              cardId: cardId,
            ),
            icon: KIcon.brightnessAlert,
            background: AppColors.materialThemeWhite,
          ),
          KSizedBox.kHeightSizedBox6,
          Text(
            context.l10n.complaint,
            style: AppTextStyle.materialThemeLabelSmall,
          ),
        ],
      ),
    );
  }
}
