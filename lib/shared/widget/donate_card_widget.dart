import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/shared.dart';

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
              ),
            ),
            Expanded(
              child: fundModel.image != null
                  ? ImageWidget(
                      key: KWidgetkeys.widget.donateCard.image,
                      imageUrl: fundModel.image!.downloadURL,
                    )
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: isDesk
                  ? const EdgeInsets.symmetric(
                      horizontal: KPadding.kPaddingSize16,
                    )
                  : EdgeInsets.zero,
              child: Text(
                fundModel.title,
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
                  fundModel.description,
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
              onPressed: () => _launchURL(fundModel.projectsLink!),
              isDesk: isDesk,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
