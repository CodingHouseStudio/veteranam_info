import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ComplaintWidget extends StatelessWidget {
  const ComplaintWidget({
    required this.isDesk,
    required this.cardEnum,
    super.key,
  });
  final bool isDesk;
  final CardEnum cardEnum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize10),
          child: IconButtonWidget(
            key: KWidgetkeys.widget.reportDialog.button,
            onPressed: () => context.dialog
                .showReportDialog(isDesk: isDesk, cardEnum: cardEnum),
            icon: KIcon.brightnessAlert,
            background: AppColors.materialThemeWhite,
          ),
        ),
        KSizedBox.kHeightSizedBox6,
        Text(
          context.l10n.complaint,
          style: AppTextStyle.materialThemeLabelSmall,
        ),
      ],
    );
  }
}
