part of 'body/home_body_widget.dart';

List<Widget> _boxWidgetList({
  required BuildContext context,
  required bool isDesk,
}) =>
    [
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox16,
      if (isDesk)
        Row(
          children: [
            Expanded(
              flex: 2,
              child: HomeBoxWidget(
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: Column(
                children: [
                  BoxWidget(
                    key: KWidgetkeys.screen.home.discountsBox,
                    text: context.l10n.discountsCoupons,
                    onTap: () => context.goNamed(
                      KRoute.discounts.name,
                    ),
                    isDesk: isDesk,
                  ),
                  if (isDesk)
                    KSizedBox.kHeightSizedBox24
                  else
                    KSizedBox.kHeightSizedBox16,
                  BoxWidget(
                    key: KWidgetkeys.screen.home.workBox,
                    text: context.l10n.work,
                    onTap: () => context.goNamed(KRoute.work.name),
                    isDesk: isDesk,
                  ),
                ],
              ),
            ),
          ],
        )
      else ...[
        HomeBoxWidget(
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.discountsBox,
          text: context.l10n.discountsCoupons,
          onTap: () => context.goNamed(
            KRoute.discounts.name,
          ),
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.workBox,
          text: context.l10n.work,
          onTap: () => context.goNamed(KRoute.work.name),
          isDesk: isDesk,
        ),
      ],
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox16,
      if (isDesk)
        Row(
          children: [
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.informationBox,
                text: context.l10n.information,
                onTap: () => context.goNamed(
                  KRoute.information.name,
                ),
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.storyBox,
                text: context.l10n.stories,
                onTap: () => context.goNamed(KRoute.story.name),
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.investorsBox,
                text: context.l10n.investors,
                onTap: () => context.goNamed(
                  KRoute.investors.name,
                ),
                isDesk: isDesk,
              ),
            ),
          ],
        )
      else ...[
        BoxWidget(
          key: KWidgetkeys.screen.home.informationBox,
          text: context.l10n.information,
          onTap: () => context.goNamed(
            KRoute.information.name,
          ),
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.storyBox,
          text: context.l10n.stories,
          onTap: () => context.goNamed(KRoute.story.name),
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.investorsBox,
          text: context.l10n.investors,
          onTap: () => context.goNamed(KRoute.investors.name),
          isDesk: isDesk,
        ),
      ],
      if (isDesk) KSizedBox.kHeightSizedBox160 else KSizedBox.kHeightSizedBox40,
      Padding(
        padding: const EdgeInsets.all(
          KPadding.kPaddingSize16,
        ),
        child: Text(
          context.l10n.faq,
          key: KWidgetkeys.screen.home.questionListTitle,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
        ),
      ),
    ];
