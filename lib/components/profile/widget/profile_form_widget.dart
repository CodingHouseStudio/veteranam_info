import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/profile/profile.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({
    required this.isDesk,
    required this.initialName,
    required this.initialSurname,
    required this.initialNickname,
    required this.initialEmail,
    required this.photoURL,
    super.key,
  });

  final bool isDesk;
  final String? photoURL;
  final String? initialName;
  final String? initialEmail;
  final String? initialSurname;
  final String? initialNickname;

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  // late TextEditingController nicknameController;
  late Timer timer;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.initialName);
    surnameController = TextEditingController(text: widget.initialSurname);
    emailController = TextEditingController(text: widget.initialEmail);
    // nicknameController = TextEditingController(text: widget.initialNickname);

    super.initState();
    // nickname();
  }

  // void nickname() {
  //   var counter = 0;
  //   timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (Timer timer) {
  //       if (counter < 5 &&
  //           (context
  //                   .read<AuthenticationBloc>()
  //                   .state
  //                   .userSetting
  //                   .nickname
  //                   ?.isEmpty ??
  //               true)) {
  //         counter++;
  //       } else {
  //         nicknameController.text =
  //             context.read<AuthenticationBloc>().state.userSetting.nickname
  // ??
  //                 '';
  //         timer.cancel();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserPhotoWidget(
              key: KWidgetkeys.screen.profile.photo,
              onPressed: () => context
                  .read<ProfileBloc>()
                  .add(const ProfileEvent.imageUpdated()),
              imageUrl: widget.photoURL,
              perimeter: KSize.kPixel72,
              icon: KIcon.personEdit,
              background: AppColors.materialThemeKeyColorsPrimary,
              iconColor: AppColors.materialThemeBlack,
            ),
            KSizedBox.kWidthSizedBox32,
            if (widget.isDesk)
              Expanded(
                child: Text(
                  context.l10n.dataEditing,
                  key: KWidgetkeys.widget.profileCard.editText,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                ),
              )
            else
              Expanded(
                child: Text(
                  context.l10n.dataEditing,
                  key: KWidgetkeys.widget.profileCard.editText,
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                ),
              ),
            KSizedBox.kWidthSizedBox8,
            KIcon.edit,
          ],
        ),
        KSizedBox.kHeightSizedBox32,
        _textField(
          fieldKey: KWidgetkeys.screen.profile.nameField,
          controller: nameController,
          hint: context.l10n.writeYouName,
          onChanged: (text) =>
              context.read<ProfileBloc>().add(ProfileEvent.nameUpdated(text)),
          isDesk: widget.isDesk,
        ),
        KSizedBox.kHeightSizedBox32,
        _textField(
          fieldKey: KWidgetkeys.screen.profile.lastNameField,
          controller: surnameController,
          hint: context.l10n.writeYouLastName,
          onChanged: (text) => context
              .read<ProfileBloc>()
              .add(ProfileEvent.surnameUpdated(text)),
          isDesk: widget.isDesk,
        ),
        KSizedBox.kHeightSizedBox32,
        _textField(
          fieldKey: KWidgetkeys.screen.profile.emailFied,
          controller: emailController,
          hint: KMockText.email,
          enabled: false,
          isDesk: widget.isDesk,
        ),
        // KSizedBox.kHeightSizedBox32,
        // _textField(
        //   fieldKey: KWidgetkeys.screen.profile.nickNameField,
        //   hint: KAppText.nickname,
        //   controller: nicknameController,
        //   onChanged: (text) => context
        //       .read<ProfileBloc>()
        //       .add(ProfileEvent.nicknameUpdated(text)),
        //   isDesk: widget.isDesk,
        // ),
        KSizedBox.kHeightSizedBox16,
        SendingTextWidget(
          textKey: KWidgetkeys.screen.login.submitingText,
          failureText:
              context.read<ProfileBloc>().state.failure?.value(context),
          sendingText: context.l10n.dataSendInProgress,
          successText:
              context.read<ProfileBloc>().state.formState == ProfileEnum.success
                  ? context.l10n.dataIsUpdatedSuccess
                  : context.l10n.dataUnmodified,
          showSuccessText: context.read<ProfileBloc>().state.formState ==
                  ProfileEnum.success ||
              context.read<ProfileBloc>().state.formState ==
                  ProfileEnum.succesesUnmodified,
          showSendingText: context.read<ProfileBloc>().state.formState ==
              ProfileEnum.sendInProgress,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.profile.saveButton,
          text: context.l10n.saveChangesProfile,
          color: AppColors.materialThemeKeyColorsSecondary,
          textColor: AppColors.materialThemeWhite,
          icon: KIcon.check.copyWith(color: AppColors.materialThemeWhite),
          deskPadding: const EdgeInsets.symmetric(
            vertical: KPadding.kPaddingSize12,
            horizontal: KPadding.kPaddingSize32,
          ),
          deskIconPadding: KPadding.kPaddingSize12,
          onPressed: () =>
              context.read<ProfileBloc>().add(const ProfileEvent.save()),
          isDesk: widget.isDesk,
          mobTextWidth: double.infinity,
          mobVerticalTextPadding: KPadding.kPaddingSize16,
          mobIconPadding: KPadding.kPaddingSize16,
        ),
      ],
    );
  }

  Widget _textField({
    required String hint,
    required Key fieldKey,
    required TextEditingController controller,
    required bool isDesk,
    void Function(String text)? onChanged,
    bool enabled = true,
  }) {
    return TextFieldWidget(
      widgetKey: fieldKey,
      enabled: enabled,
      controller: controller,
      labelText: hint,
      hintStyle: isDesk
          ? AppTextStyle.materialThemeTitleMedium
          : AppTextStyle.materialThemeTitleSmall,
      // fillColor: AppColors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize16,
        horizontal: KPadding.kPaddingSize32,
      ),
      isDesk: isDesk,
      onChanged: onChanged,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    // nicknameController.dispose();
    timer.cancel();
    super.dispose();
  }
}
