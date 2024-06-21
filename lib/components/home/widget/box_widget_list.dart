part of 'body/home_body_widget.dart';

List<Widget> _boxWidgetList({
  required BuildContext context,
  required bool isDesk,
  required bool isTablet,
  required GlobalKey aboutProjectKey,
}) =>
    [
      if (isTablet) KSizedBox.kHeightSizedBox6 else KSizedBox.kHeightSizedBox24,
      if (isTablet)
        Row(
          children: [
            Expanded(
              flex: 2,
              child: HomeBoxWidget(
                aboutProjectKey: aboutProjectKey,
                isDesk: isDesk,
                isTablet: true,
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
                      onTap: () =>
                          context.goNamedWithScroll(KRoute.stories.name),
                      isDesk: true,
                      icon: KIcon.messageSquare,
                    ),
                    KSizedBox.kHeightSizedBox24,
                    BoxWidget(
                      key: KWidgetkeys.screen.home.workBox,
                      text: context.l10n.work,
                      onTap: () => context.goNamedWithScroll(KRoute.work.name),
                      isDesk: true,
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
          aboutProjectKey: aboutProjectKey,
          isDesk: false,
          isTablet: false,
        ),
        if (Config.isDevelopment) ...[
          KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamedWithScroll(KRoute.stories.name),
            isDesk: false,
            icon: KIcon.messageSquare,
          ),
          KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.workBox,
            text: context.l10n.work,
            onTap: () => context.goNamedWithScroll(KRoute.work.name),
            isDesk: false,
            icon: KIcon.briefcase,
          ),
        ],
      ],
      KSizedBox.kHeightSizedBox16,
      if (isTablet)
        Row(
          children: [
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.informationBox,
                text: context.l10n.information,
                onTap: () => context.goNamedWithScroll(
                  KRoute.information.name,
                ),
                isDesk: isTablet,
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
                isDesk: isTablet,
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
                isDesk: isTablet,
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
          isDesk: isTablet,
          icon: KIcon.globe,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.discountsBox,
          text: context.l10n.discounts,
          onTap: () => context.goNamedWithScroll(
            KRoute.discounts.name,
          ),
          isDesk: isTablet,
          icon: KIcon.tag,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.investorsBox,
          text: context.l10n.investors,
          onTap: () => context.goNamedWithScroll(KRoute.investors.name),
          isDesk: isTablet,
          icon: KIcon.fileText,
        ),
      ],
    ];
