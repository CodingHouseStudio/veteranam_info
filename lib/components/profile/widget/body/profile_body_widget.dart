import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
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
                style: AppTextStyle.text40,
              ),
              Text(
                context.l10n.profileDetails,
                style: AppTextStyle.text16,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                ),
                child: _buildBoxWidgets(context, isDesk),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDesk) {
    return Padding(
      padding: const EdgeInsets.all(KPadding.kPaddingSize4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBoxWidgets(context, isDesk),
          ProfileCardWidget(
            key: KWidgetkeys.widget.profileCard.profileCard,
            isDesk: isDesk,
          ),
          KSizedBox.kHeightSizedBox24,
          ButtonWidget(
            text: context.l10n.logOut,
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
            isDesk: isDesk,
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
          KSizedBox.kHeightSizedBox24,
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
      padding: const EdgeInsets.all(KPadding.kPaddingSize8),
      child: Column(
        children: [
          BoxWidget(
            text: context.l10n.saved,
            isDesk: isDesk,
            onTap: null,
          ),
          KSizedBox.kHeightSizedBox30,
          BoxWidget(
            text: context.l10n.myStory,
            isDesk: isDesk,
            onTap: null,
          ),
          KSizedBox.kHeightSizedBox30,
        ],
      ),
    );
  }
}
