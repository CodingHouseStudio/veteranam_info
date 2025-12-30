import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsDescriptionWidget extends StatelessWidget {
  const InvestorsDescriptionWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _InvestorsSectionWidget(
              isDesk: true,
            ),
          ),
          InvestorsImagesWidget(isDesk: true),
        ],
      );
    } else {
      return const Column(
        children: [
          _InvestorsSectionWidget(
            isDesk: false,
          ),
          InvestorsImagesWidget(isDesk: false),
        ],
      );
    }
  }
}

class _InvestorsSectionWidget extends StatelessWidget {
  const _InvestorsSectionWidget({required this.isDesk});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      isDesk: isDesk,
      route: () => context.goNamed(KRoute.feedback.name),
      title: context.l10n.supportOurVeterans,
      buttonKey: InvestorsKeys.feedbackButton,
      subtitle: context.l10n.investorsSubtitle,
      subtitleKey: InvestorsKeys.feedbackSubtitle,
      textButton: context.l10n.writeMessage,
      titleKey: InvestorsKeys.feedbackTitle,
    );
  }
}
