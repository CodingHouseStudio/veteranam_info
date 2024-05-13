import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) =>
      [
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
            isDesk ? KPadding.kPaddingSize4 : KPadding.kPaddingSize16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.myProfile,
                style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
              ),
              Text(
                context.l10n.profileDetails,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
              KSizedBox.kHeightSizedBox30,
            ],
          ),
        ),
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
            KSizedBox.kWidthSizedBox90,
            Expanded(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize8,
                  ),
                  child: _buildBoxWidgets(context, isDesk),
                ),
              ),
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox56,
        Row(
          children: [
            Expanded(
              flex: -3,
              child: Padding(
                padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                child: ButtonWidget(
                  text: context.l10n.logOut,
                  onPressed: () => context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested()),
                  isDesk: isDesk,
                ),
              ),
            ),
            KSizedBox.kWidthSizedBox56,
            Expanded(
              flex: -2,
              child: Padding(
                padding: const EdgeInsets.all(KPadding.kPaddingSize4),
                child: ButtonWidget(
                  text: context.l10n.deleteAccount,
                  isDesk: isDesk,
                  onPressed: null,
                  // backgroundColor: AppColors.transparent,
                ),
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
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize4),
            child: ButtonWidget(
              text: context.l10n.deleteAccount,
              isDesk: isDesk,
              onPressed: null,
              // backgroundColor: AppColors.transparent,
            ),
          ),
          KSizedBox.kHeightSizedBox24,
        ],
      ),
    );
  }

  Widget _buildBoxWidgets(BuildContext context, bool isDesk) {
    return Padding(
      padding: const EdgeInsets.all(KPadding.kPaddingSize4),
      child: Column(
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
            onTap: null,
            textRightPadding: KPadding.kPaddingSize56,
            textIconPaddingWidget: KSizedBox.kHeightSizedBox56,
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
      ),
    );
  }
}
