import 'package:flutter/widgets.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsTitleWidget extends StatelessWidget {
  const InvestorsTitleWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final title = [
      KSizedBox.kHeightSizedBox24,
      TitlePointWidget(
        title: context.l10n.provideSuggestionsFromBusinesses,
        titleKey: KWidgetkeys.screen.investors.title,
        titleSecondPart: context.l10n.orDonateHere,
        isDesk: isDesk,
        isRightArrow: false,
        titleAlignment: WrapAlignment.end,
        textAlign: TextAlign.end,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox40 else KSizedBox.kHeightSizedBox24,
      InvestorsDescriptionWidget(
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox40 else KSizedBox.kHeightSizedBox24,
      Center(
        child: Text(
          context.l10n.provenFunds,
          key: KWidgetkeys.screen.investors.fundsTitle,
          style: AppTextStyle.materialThemeDisplayMedium,
        ),
      ),
    ];
    return SliverList.builder(
      itemBuilder: (context, index) => title.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: title.length,
    );
  }
}
