import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.formState != current.formState,
      builder: (context, state) {
        return ScaffoldWidget(
          mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
            precent: KDimensions.thirtyPercent,
            verticalPadding: KPadding.kPaddingSize48,
          ),
          titleChildWidgetsFunction: ({required isDesk}) => [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            ShortTitleIconWidget(
              title: context.l10n.myProfileTitle,
              titleKey: KWidgetkeys.screen.profile.title,
              isDesk: isDesk,
              icon: KIcon.arrowDownRight,
              firstIcon: !isDesk,
            ),
          ],
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            KSizedBox.kHeightSizedBox48,
            DecoratedBox(
              decoration: KWidgetTheme.boxDecorationHome,
              child: Padding(
                padding: isDesk
                    ? const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize48,
                        horizontal: KPadding.kPaddingSize64,
                      )
                    : const EdgeInsets.all(
                        KPadding.kPaddingSize16,
                      ),
                child: Column(
                  children: [
                    profileForm(isDesk: isDesk, context: context),
                    if (isDesk)
                      KSizedBox.kHeightSizedBox32
                    else
                      KSizedBox.kHeightSizedBox48,
                    if (isDesk)
                      profileButtonsDesk(context: context, isDesk: isDesk)
                    else ...[
                      profileButtonsMob(context: context, isDesk: isDesk),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Column profileButtonsMob({
    required BuildContext context,
    required bool isDesk,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ButtonAdditionalWidget(
          key: KWidgetkeys.screen.profile.logOutButton,
          text: context.l10n.logOut,
          picture: KIcon.logOut,
          onPressed: () => context.dialog.showLogoutConfirmationDialog(
            isDesk: true,
          ),
          isDesk: isDesk,
          expanded: true,
          mobPadding: const EdgeInsets.symmetric(
            vertical: KPadding.kPaddingSize16,
          ),
          iconPadding: KPadding.kPaddingSize16,
        ),
        KSizedBox.kHeightSizedBox16,
        TextButton(
          key: KWidgetkeys.screen.profile.deleteButton,
          style: KButtonStyles.borderSecondaryButtonStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
            ),
            child: Text(
              context.l10n.deleteAccount,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
          onPressed: () => context.dialog.showDeleteConfirmationDialog(
            isDesk: isDesk,
          ),
          //isDesk: true,
        ),
      ],
    );
  }

  Row profileButtonsDesk({
    required BuildContext context,
    required bool isDesk,
  }) {
    return Row(
      children: [
        Expanded(
          child: ButtonAdditionalWidget(
            key: KWidgetkeys.screen.profile.logOutButton,
            text: context.l10n.logOut,
            picture: KIcon.logOut,
            onPressed: () => context.dialog.showLogoutConfirmationDialog(
              isDesk: true,
            ),
            isDesk: isDesk,
            expanded: true,
          ),
        ),
        KSizedBox.kWidthSizedBox40, // Keep a constant width here
        Expanded(
          child: TextButton(
            key: KWidgetkeys.screen.profile.deleteButton,
            style: KButtonStyles.borderSecondaryButtonStyle,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize12,
              ),
              child: Text(
                context.l10n.deleteAccount,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
            ),
            onPressed: () => context.dialog.showDeleteConfirmationDialog(
              isDesk: isDesk,
            ),
          ),
        ),
      ],
    );
  }

  ProfileFormWidget profileForm({
    required bool isDesk,
    required BuildContext context,
  }) {
    return ProfileFormWidget(
      isDesk: isDesk,
      photoURL: context.read<AuthenticationBloc>().state.user.photo,
      initialName: context.read<AuthenticationBloc>().state.user.firstName,
      initialEmail: context.read<AuthenticationBloc>().state.user.email,
      initialSurname: context.read<AuthenticationBloc>().state.user.lastName,
      initialNickname:
          context.read<AuthenticationBloc>().state.userSetting.nickname,
    );
  }
}
