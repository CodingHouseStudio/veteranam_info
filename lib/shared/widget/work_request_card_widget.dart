import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WorkRequestCardWidget extends StatelessWidget {
  const WorkRequestCardWidget({required this.isDesk, super.key});

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.boxDecorationWidget,
      padding: EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize16,
        horizontal: isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
        children: [
          Text(
            context.l10n.didNotFindYourVacancy,
            key: WorkRequestCardKeys.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
          ),
          Text(
            context.l10n.workRequestSubtitle,
            key: WorkRequestCardKeys.subtitle,
            style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
          ButtonWidget(
            key: WorkRequestCardKeys.button,
            isDesk: isDesk,
            text: context.l10n.leaveRequest,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
