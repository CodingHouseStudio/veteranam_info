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
            if (Config.isDevelopment) ...[
              KSizedBox.kWidthSizedBox24,
              Expanded(
                child: Column(
                  children: [
                    BoxWidget(
                      key: KWidgetkeys.screen.home.storyBox,
                      text: context.l10n.stories,
                      onTap: () => context.goNamedWithScroll(KRoute.story.name),
                      isDesk: isDesk,
                      icon: KIcon.messageSquare,
                    ),
                    if (isDesk)
                      KSizedBox.kHeightSizedBox24
                    else
                      KSizedBox.kHeightSizedBox16,
                    BoxWidget(
                      key: KWidgetkeys.screen.home.workBox,
                      text: context.l10n.work,
                      onTap: () => context.goNamedWithScroll(KRoute.work.name),
                      isDesk: isDesk,
                      icon: KIcon.briefcase,
                    ),
                  ],
                ),
              ),
            ],
          ],
        )
      else ...[
        HomeBoxWidget(
          isDesk: isDesk,
        ),
        if (Config.isDevelopment) ...[
          KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamedWithScroll(KRoute.story.name),
            isDesk: isDesk,
            icon: KIcon.messageSquare,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox24
          else
            KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.workBox,
            text: context.l10n.work,
            onTap: () => context.goNamedWithScroll(KRoute.work.name),
            isDesk: isDesk,
            icon: KIcon.briefcase,
          ),
        ],
      ],
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox16,
      if (isDesk)
        Row(
          children: [
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.informationBox,
                text: context.l10n.information,
                onTap: () => context.goNamedWithScroll(
                  KRoute.information.name,
                ),
                isDesk: isDesk,
                icon: KIcon.globe,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.discountsBox,
                text: context.l10n.discounts,
                onTap: () => context.goNamedWithScroll(
                  KRoute.discounts.name,
                ),
                isDesk: isDesk,
                icon: KIcon.tag,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.investorsBox,
                text: context.l10n.investors,
                onTap: () => context.goNamedWithScroll(
                  KRoute.investors.name,
                ),
                isDesk: isDesk,
                icon: KIcon.fileText,
              ),
            ),
          ],
        )
      else ...[
        BoxWidget(
          key: KWidgetkeys.screen.home.informationBox,
          text: context.l10n.information,
          onTap: () => context.goNamedWithScroll(
            KRoute.information.name,
          ),
          isDesk: isDesk,
          icon: KIcon.globe,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.discountsBox,
          text: context.l10n.discounts,
          onTap: () => context.goNamedWithScroll(
            KRoute.discounts.name,
          ),
          isDesk: isDesk,
          icon: KIcon.tag,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.investorsBox,
          text: context.l10n.investors,
          onTap: () => context.goNamedWithScroll(KRoute.investors.name),
          isDesk: isDesk,
          icon: KIcon.fileText,
        ),
      ],
    ];
