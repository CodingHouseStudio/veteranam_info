import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DonateCardWidget extends StatelessWidget {
  const DonateCardWidget({
    required this.hasSubtitle,
    required this.fundModel,
    required this.isDesk,
    super.key,
    this.titleStyle,
  });

  final FundModel fundModel;
  final bool hasSubtitle;
  final TextStyle? titleStyle;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: KWidgetkeys.widget.donateCard.widget,
        decoration: KWidgetTheme.boxDecorationCard,
        constraints: const BoxConstraints(
          minHeight: KMinMaxSize.minHeight640,
          maxWidth: KMinMaxSize.maxWidth640,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (fundModel.image != null)
              CachedNetworkImage(
                key: KWidgetkeys.widget.donateCard.image,
                imageUrl: fundModel.image.firstImage!,
                placeholder: (context, url) => Image.asset(''),
                errorWidget: (context, url, error) => KIcon.error,
                fit: BoxFit.fill,
              ),
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize16,
                    ),
                    child: Text(
                      fundModel.title,
                      key: KWidgetkeys.widget.donateCard.title,
                      style: titleStyle ??
                          (isDesk ? AppTextStyle.text32 : AppTextStyle.text24),
                    ),
                  ),
                  if (hasSubtitle)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KPadding.kPaddingSize16,
                        vertical: KPadding.kPaddingSize16,
                      ),
                      child: Text(
                        fundModel.subtitle,
                        key: KWidgetkeys.widget.donateCard.subtitle,
                        style:
                            isDesk ? AppTextStyle.text18 : AppTextStyle.text16,
                      ),
                    ),
                  KSizedBox.kHeightSizedBox16,
                  DonateButtonWidget(
                    key: KWidgetkeys.widget.donateCard.button,
                    text: context.l10n.support,
                    isDesk: isDesk,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
