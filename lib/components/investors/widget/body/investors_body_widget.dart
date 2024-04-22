import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        FeedbackWidget(
          title: context.l10n.investors,
          subtitle: context.l10n.investorsSubtitle,
          messageHint: context.l10n.writeYourSuggenstions,
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox56,
        Text(
          context.l10n.funds,
          style: AppTextStyle.text96,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.fundsSubtitle,
          style: AppTextStyle.text24,
        ),
        KSizedBox.kHeightSizedBox56,
        DonatesCardsWidget(
          key: KWidgetkeys.screen.investors.donateCards,
          image: const [
            '',
            '',
            '',
          ],
          title: const [
            KMockText.donateCardTitle,
            KMockText.donateCardTitle,
            KMockText.donateCardTitle,
          ],
          subtitle: const [
            KMockText.donateCardSubtitle,
            KMockText.donateCardSubtitle,
            KMockText.donateCardSubtitle,
          ],
          link: const [],
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox56,
      ],
    );
  }
}
