import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkCardWidget extends StatelessWidget {
  const WorkCardWidget({
    required this.workModel,
    required this.isDesk,
    super.key,
  });
  final WorkModel workModel;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidgetTheme.boxDecorationWidget,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
          vertical: KPadding.kPaddingSize16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workModel.title,
              key: KWidgetkeys.widget.workCard.title,
              style: AppTextStyle.text40,
            ),
            Text(
              workModel.price,
              key: KWidgetkeys.widget.workCard.price,
              style: AppTextStyle.text40,
            ),
            Text(
              workModel.city ?? '',
              key: KWidgetkeys.widget.workCard.city,
              style: AppTextStyle.text20.copyWith(
                color: AppColors.lightGray,
              ),
            ),
            Text(
              workModel.companyName,
              key: KWidgetkeys.widget.workCard.employer,
              style: AppTextStyle.text20.copyWith(
                color: AppColors.lightGray,
              ),
            ),
            KSizedBox.kHeightSizedBox16,
            CardTextDetailWidget(
              text: workModel.description,
              maxLines: 3,
              icon: Row(
                children: [
                  KIcon.share.setIconKey(KWidgetkeys.widget.workCard.iconShare),
                  KSizedBox.kWidthSizedBox16,
                  KIcon.safe.setIconKey(KWidgetkeys.widget.workCard.iconSafe),
                ],
              ),
            ),
            KSizedBox.kHeightSizedBox16,
            ButtonWidget(
              key: KWidgetkeys.widget.workCard.button,
              onPressed: () {},
              text: context.l10n.respond,
              isDesk: isDesk,
            ),
          ],
        ),
      ),
    );
  }
}
