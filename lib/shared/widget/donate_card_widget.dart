import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DonateCardWidget extends StatelessWidget {
  const DonateCardWidget({
    required this.hasSubtitle,
    required this.fundModel,
    required this.isDesk,
    // required this.reportEvent,
    super.key,
    this.titleStyle,
  });

  final FundModel fundModel;
  final bool hasSubtitle;
  final TextStyle? titleStyle;
  final bool isDesk;
  // final void Function()? reportEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: KWidgetkeys.widget.donateCard.widget,
        decoration: KWidgetTheme.boxDecorationCard,
        constraints: const BoxConstraints(
          minHeight: KMinMaxSize.minHeight640,
          maxHeight: KMinMaxSize.minHeight640,
          maxWidth: KMinMaxSize.maxWidth640,
        ),
        padding: const EdgeInsets.all(KPadding.kPaddingSize16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ComplaintWidget(
                isDesk: isDesk,
                cardEnum: CardEnum.funds,
                // afterEvent: reportEvent,
                cardId: fundModel.id,
              ),
            ),
            fundModel.getImage,
            Padding(
              padding: isDesk
                  ? const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize16,
                    )
                  : EdgeInsets.zero,
              child: Text(
                fundModel.title
                    .getTrnslation(en: fundModel.titleEN, context: context),
                key: KWidgetkeys.widget.donateCard.title,
                style: titleStyle ?? AppTextStyle.materialThemeHeadlineLarge,
              ),
            ),
            if (hasSubtitle)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesk ? KPadding.kPaddingSize16 : 0,
                  vertical: KPadding.kPaddingSize16,
                ),
                child: Text(
                  fundModel.description.getTrnslation(
                    en: fundModel.descriptionEN,
                    context: context,
                  ),
                  key: KWidgetkeys.widget.donateCard.subtitle,
                  style: isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
              ),
            KSizedBox.kHeightSizedBox16,
            DonateButtonWidget(
              key: KWidgetkeys.widget.donateCard.button,
              text: context.l10n.support,
              onPressed: () => context
                  .read<UrlCubit>()
                  .launchUrl(url: fundModel.projectsLink ?? fundModel.link),
              isDesk: isDesk,
            ),
          ],
        ),
      ),
    );
  }
}
