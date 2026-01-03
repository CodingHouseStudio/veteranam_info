import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class WorkCardWidget extends StatelessWidget {
  const WorkCardWidget({
    required this.workModel,
    required this.isDesk,
    this.firstItemIsFirst = false,
    this.isSaved = true,
    super.key,
  });

  final WorkModel workModel;
  final bool isDesk;
  final bool firstItemIsFirst;
  final bool isSaved;

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
          spacing: KPadding.kPaddingSize4,
          children: [
            Text(
              workModel.title,
              key: WorkCardKeys.title,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            Text(
              workModel.price,
              key: WorkCardKeys.price,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            Text(
              workModel.city ?? '',
              key: WorkCardKeys.city,
              style: isDesk ? AppTextStyle.hint20 : AppTextStyle.hint16,
            ),
            Text(
              workModel.companyName,
              key: WorkCardKeys.employer,
              style: isDesk ? AppTextStyle.hint20 : AppTextStyle.hint16,
            ),
            KSizedBox.kHeightSizedBox12,
            CardTextDetailWidget(
              text: workModel.description,
              maxLines: 3,
              icon: Row(
                spacing: KPadding.kPaddingSize16,
                children: [
                  KIcon.share.copyWith(key: WorkCardKeys.iconShare),
                  if (isSaved)
                    KIcon.safe.copyWith(key: WorkCardKeys.iconSafe)
                  else
                    KIcon.saved.copyWith(
                      key: WorkCardKeys.iconSafe,
                    ),
                ],
              ),
              isDesk: isDesk,
            ),
            KSizedBox.kHeightSizedBox12,
            ButtonWidget(
              key: WorkCardKeys.button,
              onPressed: () => context.goNamed(KRoute.employeeRespond.name),
              text: context.l10n.respond,
              isDesk: isDesk,
            ),
          ],
        ),
      ),
    );
  }
}
