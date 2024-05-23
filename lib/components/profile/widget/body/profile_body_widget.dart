import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
        ...TitleWidget.titleWidgetList(
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
          _buildDesktopLayout(context, isDesk)
        else
          _buildMobileLayout(context, isDesk),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesk) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ProfileCardWidget(
                key: KWidgetkeys.widget.profileCard.profileCard,
                isDesk: isDesk,
              ),
            ),
            KSizedBox.kWidthSizedBox80,
            Expanded(
              child: IntrinsicHeight(
                child: _buildBoxWidgets(context, isDesk),
              ),
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox56,
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDesk) {
    return Padding(
      padding: const EdgeInsets.all(KPadding.kPaddingSize4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBoxWidgets(context, isDesk),
          ProfileCardWidget(
            key: KWidgetkeys.widget.profileCard.profileCard,
            isDesk: isDesk,
          ),
          KSizedBox.kHeightSizedBox24,
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize4),
            child: ButtonWidget(
              text: context.l10n.logOut,
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
              isDesk: isDesk,
            ),
          ),
          if (isDesk)
            KSizedBox.kWidthSizedBox24
          else
            KSizedBox.kHeightSizedBox24,
          ButtonWidget(
            text: context.l10n.deleteAccount,
            isDesk: isDesk,
            onPressed: null,
            // backgroundColor: AppColors.transparent,
          ),
          KSizedBox.kWidthSizedBox80,
          KSizedBox.kHeightSizedBox24,
        ],
      ),
    );
  }

  Widget _buildBoxWidgets(BuildContext context, bool isDesk) {
    return Column(
      children: [
        BoxWidget(
          text: context.l10n.saved,
          isDesk: isDesk,
          onTap: null,
          textRightPadding: KPadding.kPaddingSize56,
          textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
        ),
        KSizedBox.kHeightSizedBox30,
        BoxWidget(
          text: context.l10n.myStory,
          isDesk: isDesk,
          textRightPadding: KPadding.kPaddingSize56,
          textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
          onTap: () => context.goNamedWithScroll(KRoute.profileMyStory.name),
        ),
        KSizedBox.kHeightSizedBox30,
        if (isDesk)
          BoxWidget(
            text: context.l10n.myFeedback,
            isDesk: isDesk,
            onTap: null,
            textRightPadding: KPadding.kPaddingSize56,
            textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
          ),
      ],
    );
  }
}
