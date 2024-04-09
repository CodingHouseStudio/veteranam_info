import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedbackWidget(
      title: context.l10n.investors,
      subtitle: context.l10n.investorsSubtitle,
      messageHint: context.l10n.writeYourSuggenstions,
    );
  }
}
