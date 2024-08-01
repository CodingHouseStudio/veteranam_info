import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    required this.informationItem,
    required this.isDesk,
    required this.share,
    this.onLikeChange,
    super.key,
    this.closeWidget,
    this.afterReportEvent,
  });

  final InformationModel informationItem;
  final bool isDesk;
  final void Function({required bool like})? onLikeChange;
  final Widget? closeWidget;
  final void Function()? afterReportEvent;
  final String? share;

  @override
  Widget build(BuildContext context) {
    return CardTextDetailEvaluateWidget(
      image: informationItem.image,
      text: informationItem.news,
      // buttonText: [
      //   context.l10n.detail,
      //   context.l10n.hide,
      // ],
      share: share,
      buttonStyle: KButtonStyles.borderBlackButtonStyle,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            informationItem.title,
            key: KWidgetkeys.widget.newsCard.title,
            style: isDesk
                ? AppTextStyle.materialThemeDisplaySmall
                : AppTextStyle.materialThemeHeadlineSmall,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          Text(
            informationItem.fetchDate.localeTime,
            key: KWidgetkeys.widget.newsCard.date,
            style: isDesk
                ? AppTextStyle.materialThemeLabelMedium
                : AppTextStyle.materialThemeLabelSmall,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox16,
        ],
      ),
      bottom: Padding(
        padding: const EdgeInsets.only(
          bottom: KPadding.kPaddingSize8,
          top: KPadding.kPaddingSize16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                key: KWidgetkeys.widget.newsCard.tags,
                spacing: KSize.kWrapSpacing8,
                runSpacing: KSize.kWrapRunSpacing4,
                children: (context
                                .read<AuthenticationBloc>()
                                .state
                                .userSetting
                                .locale ==
                            Language.english
                        ? informationItem.category
                        : informationItem.categoryUA)
                    .map((category) {
                  return Container(
                    decoration: KWidgetTheme.boxDecorationCardGrayBorder,
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize4,
                      horizontal: KPadding.kPaddingSize8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category,
                          style: AppTextStyle.materialThemeLabelLarge,
                        ),
                        KIcon.check,
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            if (closeWidget != null) closeWidget!,
          ],
        ),
      ),
      isDesk: isDesk,
      onLikeChange: onLikeChange,
      cardId: informationItem.id,
      cardEnum: CardEnum.information,
      afterEvent: afterReportEvent,
    );
  }
}
