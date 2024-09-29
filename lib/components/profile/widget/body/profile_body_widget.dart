import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox30,
        TitleWidget(
          title: context.l10n.myProfile,
          titleKey: KWidgetkeys.screen.profile.title,
          subtitle: context.l10n.profileDetails,
          subtitleKey: KWidgetkeys.screen.profile.subtitle,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        if (isDesk)
          ..._buildDesktopLayout(context, isDesk)
        else
          ..._buildMobileLayout(context, isDesk),
      ],
    );
  }

  List<Widget> _buildDesktopLayout(BuildContext context, bool isDesk) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ProfileCardWidget(
              key: KWidgetkeys.screen.profile.profileCard,
              isDesk: isDesk,
            ),
          ),
          KSizedBox.kWidthSizedBox80,
          Expanded(
            child: IntrinsicHeight(
              child: Column(
                children: _buildBoxWidgets(context, isDesk),
              ),
            ),
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox56,
    ];
  }

  List<Widget> _buildMobileLayout(BuildContext context, bool isDesk) {
    return [
      ..._buildBoxWidgets(context, isDesk),
      ProfileCardWidget(
        key: KWidgetkeys.screen.profile.profileCard,
        isDesk: isDesk,
      ),
      KSizedBox.kHeightSizedBox24,
    ];
  }

  List<Widget> _buildBoxWidgets(BuildContext context, bool isDesk) {
    // if (isDesk) {
    return [
      Padding(
        padding: isDesk
            ? const EdgeInsets.all(KPadding.kPaddingSize8)
            : EdgeInsets.zero,
        child: Column(
          children: [
            if (Config.isBusiness) ...[
              BoxWidget(
                key: KWidgetkeys.screen.profile.boxMyDiscounts,
                text: context.l10n.myDiscounts,
                isDesk: isDesk,
                onTap: () => context.goNamed(
                  KRoute.myDiscounts.name,
                ),
              ),
              KSizedBox.kHeightSizedBox30,
            ],
            if (Config.isUser) ...[
              BoxWidget(
                key: KWidgetkeys.screen.profile.boxSaves,
                text: context.l10n.saved,
                isDesk: isDesk,
                onTap: () => context.goNamed(
                  KRoute.profileSaves.name,
                ),
              ),
              KSizedBox.kHeightSizedBox30,
            ],
            if (Config.isUser) ...[
              BoxWidget(
                key: KWidgetkeys.screen.profile.boxStory,
                text: context.l10n.myStory,
                isDesk: isDesk,
                textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
                onTap: () => context.goNamed(KRoute.profileMyStory.name),
              ),
              KSizedBox.kHeightSizedBox30,
            ],
            if (Config.isUser) ...[
              BoxWidget(
                key: KWidgetkeys.screen.profile.boxFeedback,
                text: context.l10n.myFeedback,
                isDesk: isDesk,
                textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
                onTap: null,
              ),
              KSizedBox.kHeightSizedBox30,
            ],
          ],
        ),
      ),
    ];
    // } else {
    //   return [
    //     BoxWidget(
    //       text: context.l10n.saved,
    //       isDesk: isDesk,
    //       onTap: () => context.goNamed(
    //         KRoute.profileSaves.name,
    //       ),
    //     ),
    //     KSizedBox.kHeightSizedBox30,
    //     BoxWidget(
    //       text: context.l10n.myStory,
    //       isDesk: isDesk,
    //       textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
    //       onTap: () => context.goNamed(KRoute.profileMyStory.name),
    //     ),
    //     KSizedBox.kHeightSizedBox30,
    //   ];
    // }
  }
}
