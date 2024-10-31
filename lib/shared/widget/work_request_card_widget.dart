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
        children: [
          Text(
            context.l10n.didNotFindYourVacancy,
            key: KWidgetkeys.widget.workRequestCard.title,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox8,
          Text(
            context.l10n.workRequestSubtitle,
            key: KWidgetkeys.widget.workRequestCard.subtitle,
            style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox8,
          ButtonWidget(
            key: KWidgetkeys.widget.workRequestCard.button,
            isDesk: isDesk,
            text: context.l10n.leaveRequest,
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
