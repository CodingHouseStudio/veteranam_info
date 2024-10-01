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
            precent: KDimensions.paddingMultiply02,
            verticalPadding: KPadding.kPaddingSize48,
          ),
          titleChildWidgetsFunction: ({required isDesk}) => [
            Padding(
              padding: isDesk
                  ? const EdgeInsets.only(
                      top: KPadding.kPaddingSize40,
                    )
                  : const EdgeInsets.only(
                      top: KPadding.kPaddingSize24,
                    ),
              child: isDesk
                  ? ShortTitleIconWidget(
                      title: context.l10n.myProfileTitle,
                      titleKey: KWidgetkeys.screen.profile.title,
                      isDesk: true,
                      icon: KIcon.arrowDownRight,
                    )
                  : ShortTitleIconWidget(
                      title: context.l10n.myProfileTitle,
                      titleKey: KWidgetkeys.screen.profile.title,
                      isDesk: false,
                      icon: KIcon.arrowDownRight,
                      firstIcon: true,
                    ),
            ),
          ],
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            KSizedBox.kHeightSizedBox40,
            profileForm(isDesk: isDesk, context: context),
            if (isDesk)
              KSizedBox.kHeightSizedBox32
            else
              KSizedBox.kHeightSizedBox48,
            if (isDesk)
              Row(
                children: [
                  Expanded(
                    child: ButtonAdditionalWidget(
                      key: KWidgetkeys.screen.profile.logOutButton,
                      text: context.l10n.logOut,
                      picture: KIcon.logOut,
                      onPressed: () =>
                          context.dialog.showLogoutConfirmationDialog(
                        isDesk: true,
                      ),
                      isDesk: isDesk,
                      expanded: true,
                    ),
                  ),
                  KSizedBox.kWidthSizedBox40,
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
                      onPressed: () =>
                          context.dialog.showDeleteConfirmationDialog(
                        isDesk: isDesk,
                      ),
                      //isDesk: true,
                    ),
                  ),
                ],
              )
            else ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ButtonAdditionalWidget(
                    key: KWidgetkeys.screen.profile.logOutButton,
                    text: context.l10n.logOut,
                    picture: KIcon.logOut,
                    onPressed: () =>
                        context.dialog.showLogoutConfirmationDialog(
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
                    onPressed: () =>
                        context.dialog.showDeleteConfirmationDialog(
                      isDesk: isDesk,
                    ),
                    //isDesk: true,
                  ),
                ],
              ),
            ],
          ],
        );
      },
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
