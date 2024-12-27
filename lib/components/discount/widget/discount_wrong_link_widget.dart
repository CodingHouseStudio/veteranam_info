import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountWrongLinkWidget extends StatelessWidget {
  const DiscountWrongLinkWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    final children = [
      ShortTitleIconWidget(
        title: context.l10n.invalidLinkTitle,
        titleKey: KWidgetkeys.screen.discountsAdd.title,
        isDesk: isDesk,
        expanded: !isDesk,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      if (isDesk) KSizedBox.kHeightSizedBox80 else KSizedBox.kHeightSizedBox24,
      KIcon.found,
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.discountNotFound,
        key: KWidgetkeys.screen.discountsAdd.textWrongLink,
        style: AppTextStyle.materialThemeTitleMedium,
        textAlign: isDesk ? TextAlign.center : TextAlign.start,
      ),
      KSizedBox.kHeightSizedBox16,
      Align(
        alignment: isDesk ? Alignment.center : Alignment.centerLeft,
        child: TextButton(
          key: KWidgetkeys.screen.discountsAdd.buttonWrongLink,
          onPressed: () => context.goNamed(KRoute.discounts.name),
          style: KButtonStyles.borderBlackDiscountLinkButtonStyle,
          child: Text(
            context.l10n.back,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      ),
    ];
    return SliverList.builder(
      itemCount: children.length,
      itemBuilder: (context, index) => children.elementAt(index),
    );
  }
}
