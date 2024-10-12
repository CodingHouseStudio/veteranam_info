import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/profile/profile.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.image != current.image,
      builder: (context, state) {
        return ScaffoldWidget(
          mainDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
            precent: KDimensions.thirtyPercent,
            // verticalPadding: KPadding.kPaddingSize48,
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
            if (isDesk)
              KSizedBox.kHeightSizedBox32
            else
              KSizedBox.kHeightSizedBox24,
            const Divider(
              color: AppColors.materialThemeKeyColorsNeutral,
            ),
          ],
          isForm: true,
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            KSizedBox.kHeightSizedBox48,
            DecoratedBox(
              decoration: KWidgetTheme.boxDecorationHome
                  .copyWith(color: AppColors.materialThemeKeyColorsNeutral),
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
                  photoURL: context.read<AuthenticationBloc>().state.user.photo,
                  imageBytes: state.image.value,
                  initialName:
                      context.read<AuthenticationBloc>().state.user.firstName,
                  initialEmail:
                      context.read<AuthenticationBloc>().state.user.email,
                  initialSurname:
                      context.read<AuthenticationBloc>().state.user.lastName,
                  initialNickname: context
                      .read<AuthenticationBloc>()
                      .state
                      .userSetting
                      .nickname,
                ),
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox32
            else
              KSizedBox.kHeightSizedBox48,
            if (isDesk)
              Row(
                children: [
                  Expanded(
                    child: logoutButton(
                      context: context,
                      isDesk: isDesk,
                    ),
                  ),
                  KSizedBox.kWidthSizedBox40,
                  Expanded(
                    child: deleteButton(
                      context: context,
                      isDesk: isDesk,
                    ),
                  ),
                ],
              )
            else ...[
              logoutButton(context: context, isDesk: isDesk),
              KSizedBox.kHeightSizedBox16,
              deleteButton(context: context, isDesk: isDesk),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox48
            else
              KSizedBox.kHeightSizedBox16,
          ],
        );
      },
    );
  }

  Widget logoutButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      ButtonAdditionalWidget(
        key: KWidgetkeys.screen.profile.logOutButton,
        text: context.l10n.logOut,
        picture: KIcon.logOut,
        align: Alignment.center,
        onPressed: () => context.dialog.showLogoutConfirmationDialog(
          isDesk: true,
        ),
        isDesk: isDesk,
        deskPadding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize16,
        ),
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
        widgetKey: KWidgetkeys.screen.profile.deleteButton,
        isDesk: isDesk,
        align: Alignment.center,
        style: KButtonStyles.borderNeutralButtonStyle,
        padding: const EdgeInsets.symmetric(
          vertical: KPadding.kPaddingSize16,
        ),
        text: context.l10n.deleteAccount,
        onPressed: () => context.dialog.showDeleteConfirmationDialog(
          isDesk: isDesk,
          deleteEvent: () => context.read<AuthenticationBloc>().add(
                AuthenticationDeleteRequested(),
              ),
        ),
      );
}
