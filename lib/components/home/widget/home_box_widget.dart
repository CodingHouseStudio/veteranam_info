import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class HomeBoxWidget extends StatelessWidget {
  const HomeBoxWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      key: KWidgetkeys.screen.home.box,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeightSizedBox45,
                Text(
                  context.l10n.hello,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                KSizedBox.kHeightSizedBox16,
                Text(
                  context.l10n.thisServiceForVeterans,
                  style: AppTextStyle.text64,
                ),
                KSizedBox.kHeightSizedBox24,
                Text(
                  context.l10n.thisServiceForVeteransSubtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
                KSizedBox.kHeightSizedBox16,
                DoubleButtonWidget(
                  text: context.l10n.detail,
                  textColor: AppColors.materialThemeWhite,
                  color: AppColors.materialThemeBlack,
                  onPressed: null,
                ),
                KSizedBox.kHeightSizedBox45,
              ],
            ),
          ),
          const Expanded(child: KImage.homeImage),
        ],
      ),
    );
  }
}
