import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/profile/profile.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
        precent: KDimensions.twentyEightPercent,
        // verticalPadding: KPadding.kPaddingSize48,
      ),
      showMobBottomNavigation: true,
      bottomBarIndex: 3,
      showAppBar: Config.isWeb,
      pageName: context.l10n.myProfileTitle,
      titleChildWidgetsFunction: ({required isDesk}) => [
        // if (Config.isWeb) ...[
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        ShortTitleIconWidget(
          title: context.l10n.myProfileTitle,
          titleKey: ProfileKeys.title,
          isDesk: isDesk,
          icon: KIcon.arrowDownRight,
          firstIcon: !isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox24,
        const Divider(
          color: AppColors.materialThemeRefNeutralNeutral90,
        ),
        // ],
      ],
      isForm: true,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (Config.isWeb)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox24,
        DecoratedBox(
          decoration: KWidgetTheme.boxDecorationHomeNeutral,
          child: Padding(
            padding: isDesk
                ? const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize48,
                    horizontal: KPadding.kPaddingSize64,
                  )
                : const EdgeInsets.all(
                    KPadding.kPaddingSize16,
                  ),
            child: ProfileFormWidget(
              isDesk: isDesk,
              initialName: context.read<UserWatcherBloc>().state.user.firstName,
              initialEmail: context.read<UserWatcherBloc>().state.user.email,
              initialSurname:
                  context.read<UserWatcherBloc>().state.user.lastName,
              initialNickname:
                  context.read<UserWatcherBloc>().state.userSetting.nickname,
            ),
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox48,
        if (isDesk)
          Row(
            spacing: KPadding.kPaddingSize40,
            children: [
              Expanded(
                child: logoutButton(
                  context: context,
                  isDesk: isDesk,
                ),
              ),
              Expanded(
                child: deleteButton(
                  context: context,
                  isDesk: isDesk,
                ),
              ),
            ],
          )
        else ...[
          logoutButton(context: context, isDesk: false),
          KSizedBox.kHeightSizedBox16,
          deleteButton(context: context, isDesk: isDesk),
        ],
        if (isDesk)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox16,
      ],
    );
  }

  Widget logoutButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      ButtonAdditionalWidget(
        key: ProfileKeys.logOutButton,
        text: context.l10n.logOut,
        picture: KIcon.logOut,
        align: Alignment.center,
        onPressed: () => context.dialog.showConfirmationDialog(
          isDesk: isDesk,
          title: context.l10n.logOutFromProfile,
          subtitle: context.l10n.logOutProfileQuestion,
          confirmText: context.l10n.logOut,
          confirmButtonBackground: AppColors.materialThemeKeyColorsSecondary,
          onAppliedPressed: () {
            context.read<AuthenticationBloc>().add(
                  AuthenticationLogoutRequested(),
                );
          },
        ),
        isDesk: isDesk,
        deskPadding: const EdgeInsets.only(
          top: KPadding.kPaddingSize16,
          bottom: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize40,
          left: KPadding.kPaddingSize80,
        ),
        //  const EdgeInsets.symmetric(
        //   vertical: KPadding.kPaddingSize16,
        // ),
        expanded: true,
        borderColor: AppColors.materialThemeRefNeutralNeutral80,
        mobPadding: const EdgeInsets.only(
          top: KPadding.kPaddingSize16,
          bottom: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize40,
        ),
        iconPadding: KPadding.kPaddingSize16,
        rightWidget: isDesk ? KSizedBox.kWidthSizedBox58 : null,
      );

  Widget deleteButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      SecondaryButtonWidget(
        widgetKey: ProfileKeys.deleteButton,
        isDesk: isDesk,
        align: Alignment.center,
        style: KButtonStyles.borderNeutralButtonStyle,
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize16,
        ),
        text: context.l10n.deleteAccount,
        onPressed: () => context.dialog.showConfirmationDialog(
          isDesk: isDesk,
          title: context.l10n.deleteProfile,
          subtitle: context.l10n.deleteProfileQuestion,
          confirmText: context.l10n.delete,
          confirmButtonBackground: AppColors.materialThemeRefErrorError60,
          onAppliedPressed: () {
            context.read<AuthenticationBloc>().add(
                  AuthenticationDeleteRequested(),
                );
          },
        ),
      );
}
