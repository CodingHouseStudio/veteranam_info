import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountTitleWidget extends StatelessWidget {
  const DiscountTitleWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize24),
        child: TitlePointWidget(
          title: context.l10n.specialOffers,
          titleKey: KWidgetkeys.screen.discounts.title,
          titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
          // pointText: context.l10n.discounts,
          // pointKey: KWidgetkeys.screen.discounts.
          // titlePoint,
          isDesk: isDesk,
          titleSecondPartPadding: const EdgeInsets.only(
            left: KPadding.kPaddingSize72,
          ),
          iconCrossAxisAlignment: CrossAxisAlignment.end,
          isRightArrow: false,
        ),
      ),
    );
  }
}
