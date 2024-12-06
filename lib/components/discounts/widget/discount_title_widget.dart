import 'package:flutter/material.dart';
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
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize24),
          child: LineTitleIconWidget(
            title: context.l10n.discounts,
            rightWidget: DropdownButtonHideUnderline(
              child: DropDownButtonWidget(
                isDesk: isDesk,
                buttonText: 'test',
                items: [
                  DropDownItem(
                    text: 'test2',
                    action: () {},
                    key: const Key('fds'),
                  ),
                ],
                offset: KDimensions.discountSortingDropButtonOffset,
              ),
            ),
            titleKey: KWidgetkeys.screen.discounts.title,
          ),
        ),
      ),
    );
  }
}
