import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({
    required this.isDesk,
    required this.title,
    // required this.secondText,
    super.key,
    this.titleSecondPart,
    // this.text,
  });
  final bool isDesk;
  final String title;
  final String? titleSecondPart;
  // final String? text;
  // final String secondText;

  @override
  Widget build(BuildContext context) {
    final children = isDesk
        ? <Widget>[
            KSizedBox.kHeightSizedBox24,
            if (titleSecondPart != null)
              TitlePointWidget(
                isDesk: true,
                //pointText: context.l10n.feedback,
                // pointKey: KWidgetkeys.screen.feedback.pointText,
                title: title,
                titleSecondPart: titleSecondPart!,
                titleKey: KWidgetkeys.screen.feedback.title,
              )
            else
              LineTitleIconWidget(
                title: title,
                titleKey: KWidgetkeys.screen.feedback.title, isDesk: isDesk,
                // isDesk: isDesk,
              ),
            KSizedBox.kHeightSizedBox100,
          ]
        : [
            // KSizedBox.kHeightSizedBox24,
            // TextPointWidget(
            //   context.l10n.feedback,
            //   key: KWidgetkeys.screen.feedback.pointText,
            // ),
            KSizedBox.kHeightSizedBox16,
            // if (text != null)
            //   Text(
            //     text!,
            //     style: AppTextStyle.materialThemeDisplaySmall,
            //   ),
            Row(
              key: KWidgetkeys.screen.feedback.title,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Config.isWeb ? mobTitle : mobTitle.reversed.toList(),
            ),
            KSizedBox.kHeightSizedBox32,
            const Divider(
              color: AppColors.materialThemeRefNeutralNeutral90,
            ),
            KSizedBox.kHeightSizedBox24,
          ];
    return SliverList.builder(
      itemBuilder: (context, index) => children.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: children.length,
    );
  }

  List<Widget> get mobTitle {
    return [
      IconWidget(
        icon: Config.isWeb ? KIcon.arrowDownRight : KIcon.arrowDownLeft,
        padding: KPadding.kPaddingSize12,
      ),
      KSizedBox.kWidthSizedBox16,
      Expanded(
        child: Text(
          '$title $titleSecondPart',
          style: AppTextStyle.materialThemeDisplaySmall,
        ),
      ),
    ];
  }
}
