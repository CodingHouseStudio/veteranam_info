import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts/discounts.dart';
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
        child: LineTitleIconWidget(
          title: context.l10n.discounts,
          rightWidget:
              isDesk ? const DiscountSortingWidget(isDesk: true) : null,
          titleKey: KWidgetkeys.screen.discounts.title,
        ),
      ),
    );
  }
}
