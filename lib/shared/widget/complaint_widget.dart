import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    required this.isDesk,
    required this.cardEnum,
    // required this.afterEvent,
    required this.cardId,
    super.key,
    this.background,
  });
  final bool isDesk;
  final CardEnum cardEnum;
  // final void Function()? afterEvent;
  final String cardId;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.dialog.showReportDialog(
        isDesk: isDesk,
        cardEnum: cardEnum,
        // afterEvent: afterEvent,
        cardId: cardId,
      ),
      child: Column(
        children: [
          IconWidget(
            key: KWidgetkeys.widget.reportDialog.button,
            icon: KIcon.brightnessAlert,
            background: background ?? AppColors.materialThemeWhite,
            padding: KPadding.kPaddingSize12,
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
