import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DonateCardWidget extends StatelessWidget {
  const DonateCardWidget({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.hasSubtitle,
    super.key,
    this.titleStyle,
  });
  final String image;
  final String title;
  final String subtitle;
  final bool hasSubtitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: KWidgetkeys.widget.donateCard.widget,
      decoration: KWidetTheme.boxDecorationCard,
      constraints: const BoxConstraints(
        minHeight: KMinMaxSize.minHeight640,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (image.isNotEmpty)
            CachedNetworkImage(
              key: KWidgetkeys.widget.donateCard.image,
              imageUrl: image,
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
                    title,
                    key: KWidgetkeys.widget.donateCard.title,
                    style: titleStyle ?? AppTextStyle.text32,
                  ),
                ),
                if (hasSubtitle)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize16,
                      vertical: KPadding.kPaddingSize16,
                    ),
                    child: Text(
                      subtitle,
                      key: KWidgetkeys.widget.donateCard.subtitle,
                      style: AppTextStyle.text18,
                    ),
                  ),
                KSizedBox.kHeightSizedBox16,
                DonateButtonWidget(
                  key: KWidgetkeys.widget.donateCard.button,
                  text: context.l10n.support,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
