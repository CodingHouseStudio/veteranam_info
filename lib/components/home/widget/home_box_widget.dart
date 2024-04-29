import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeBoxWidget extends StatelessWidget {
  const HomeBoxWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.screen.home.box,
      padding: EdgeInsets.only(
        top: KPadding.kPaddingSize8,
        right: KPadding.kPaddingSize8,
        bottom: isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
        left: isDesk ? KPadding.kPaddingSize48 : KPadding.kPaddingSize16,
      ),
      decoration: KWidgetTheme.boxDecorationCard,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(right: KPadding.kPaddingSize80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesk)
                    KSizedBox.kHeightSizedBox40
                  else
                    KSizedBox.kHeightSizedBox32,
                  Text(
                    context.l10n.helloVeteran,
                    key: KWidgetkeys.screen.home.boxTitle,
                    style: isDesk ? AppTextStyle.text128 : AppTextStyle.text40,
                    maxLines: 2,
                  ),
                  if (isDesk)
                    KSizedBox.kHeightSizedBox20
                  else
                    KSizedBox.kHeightSizedBox16,
                  Text(
                    context.l10n.homeSubtitle,
                    key: KWidgetkeys.screen.home.boxSubtitle,
                    style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                    maxLines: isDesk ? 2 : null,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconWidget(
              key: KWidgetkeys.screen.home.boxIcon,
              icon: KIcon.volum,
              padding: KPadding.kPaddingSize20,
            ),
          ),
        ],
      ),
    );
  }
}
