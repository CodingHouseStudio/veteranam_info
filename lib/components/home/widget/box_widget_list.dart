part of 'body/home_body_widget.dart';

List<Widget> _boxWidgetList({
  required BuildContext context,
  required bool isDesk,
  required GlobalKey aboutProjectKey,
}) =>
    [
      if (isDesk) KSizedBox.kHeightSizedBox6 else KSizedBox.kHeightSizedBox24,
      if (isDesk)
        Row(
          children: [
            Expanded(
              flex: 2,
              child: HomeBoxWidget(
                aboutProjectKey: aboutProjectKey,
                isDesk: true,
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
                      onTap: () => context.goNamed(KRoute.stories.name),
                      isDesk: true,
                      icon: KIcon.messageSquare,
                    ),
                    KSizedBox.kHeightSizedBox24,
                    BoxWidget(
                      key: KWidgetkeys.screen.home.workBox,
                      text: context.l10n.work,
                      onTap: () => context.goNamed(KRoute.work.name),
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
        ),
        if (Config.isDevelopment) ...[
          KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamed(KRoute.stories.name),
            isDesk: false,
            icon: KIcon.messageSquare,
          ),
          KSizedBox.kHeightSizedBox16,
          BoxWidget(
            key: KWidgetkeys.screen.home.workBox,
            text: context.l10n.work,
            onTap: () => context.goNamed(KRoute.work.name),
            isDesk: false,
            icon: KIcon.briefcase,
          ),
        ],
      ],
      KSizedBox.kHeightSizedBox16,
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
                icon: KIcon.globe,
              ),
            ),
            KSizedBox.kWidthSizedBox24,
            Expanded(
              child: BoxWidget(
                key: KWidgetkeys.screen.home.discountsBox,
                text: context.l10n.discounts,
                onTap: () => context.goNamed(
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
                onTap: () => context.goNamed(
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
          onTap: () => context.goNamed(
            KRoute.information.name,
          ),
          isDesk: isDesk,
          icon: KIcon.globe,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.discountsBox,
          text: context.l10n.discounts,
          onTap: () => context.goNamed(
            KRoute.discounts.name,
          ),
          isDesk: isDesk,
          icon: KIcon.tag,
        ),
        KSizedBox.kHeightSizedBox16,
        BoxWidget(
          key: KWidgetkeys.screen.home.investorsBox,
          text: context.l10n.investors,
          onTap: () => context.goNamed(KRoute.investors.name),
          isDesk: isDesk,
          icon: KIcon.fileText,
        ),
      ],
    ];
