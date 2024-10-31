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
    super.key,
  });

  final bool isDesk;
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
  // Timer? timer;

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
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.image != current.image,
      builder: (context, _) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            context.read<ProfileBloc>().add(const ProfileEvent.started());
            if (nameController.text.isEmpty) {
              nameController.text = state.user.firstName ?? '';
            }
            if (surnameController.text.isEmpty) {
              surnameController.text = state.user.lastName ?? '';
            }
            if (emailController.text.isEmpty) {
              emailController.text = state.user.email ?? '';
            }
          },
          listenWhen: (previous, current) =>
              _.formState == ProfileEnum.initial &&
              (previous.user.name != current.user.name ||
                  previous.user.email != current.user.email) &&
              previous.user.id != current.user.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: _.image.value == null
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(left: KPadding.kPaddingSize24),
                    child: UserPhotoWidget(
                      key: KWidgetkeys.screen.profile.photo,
                      onPressed: () => context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.imageUpdated()),
                      imageUrl:
                          context.read<AuthenticationBloc>().state.user.photo,
                      // perimeter: KSize.kPixel72,
                      icon: KIcon.personEdit,
                      // background: AppColors.materialThemeKeyColorsPrimary,
                      // iconColor: AppColors.materialThemeBlack,
                      imageBytes: _.image.value?.bytes,
                    ),
                  ),
                  KSizedBox.kWidthSizedBox32,
                  Expanded(
                    child: Text(
                      context.l10n.dataEditing,
                      key: KWidgetkeys.screen.profile.editText,
                      style: widget.isDesk
                          ? AppTextStyle.materialThemeHeadlineLarge
                          : AppTextStyle.materialThemeHeadlineSmall,
                    ),
                  ),
                  KSizedBox.kWidthSizedBox8,
                  KIcon.edit,
                ],
              ),
              if (_.image.value != null)
                Text(
                  context.l10n.changesNotSaved,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.materialThemeBodyMediumNeutralVariant60,
                ),
              KSizedBox.kHeightSizedBox32,
              _textField(
                fieldKey: KWidgetkeys.screen.profile.nameField,
                controller: nameController,
                hint: context.l10n.writeYouName,
                onChanged: (text) => context
                    .read<ProfileBloc>()
                    .add(ProfileEvent.nameUpdated(text)),
                isDesk: widget.isDesk,
                errorText: _.name.error.value(context),
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
                errorText: _.surname.error.value(context),
              ),
              KSizedBox.kHeightSizedBox32,
              _textField(
                fieldKey: KWidgetkeys.screen.profile.emailFied,
                controller: emailController,
                hint: KMockText.email,
                enabled: false,
                isDesk: widget.isDesk,
                errorText: null,
                showErrorText: false,
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
                textKey: KWidgetkeys.screen.profile.submitingText,
                failureText: _.failure?.value(context),
                sendingText: context.l10n.changesSendInProgress,
                successText: _.formState == ProfileEnum.success
                    ? context.l10n.dataIsUpdatedSuccess
                    : context.l10n.dataUnmodified,
                showSuccessText: _.formState == ProfileEnum.success ||
                    _.formState == ProfileEnum.succesesUnmodified,
                showSendingText: _.formState == ProfileEnum.sendInProgress,
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
          ),
        );
      },
    );
  }

  Widget _textField({
    required String hint,
    required Key fieldKey,
    required TextEditingController controller,
    required bool isDesk,
    required String? errorText,
    void Function(String text)? onChanged,
    bool enabled = true,
    bool? showErrorText,
  }) {
    return TextFieldWidget(
      widgetKey: fieldKey,
      enabled: enabled,
      isRequired: true,
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
      errorText: errorText,
      showErrorText: showErrorText ??
          context.read<ProfileBloc>().state.formState ==
              ProfileEnum.invalidData,
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
    // timer?.cancel();
    super.dispose();
  }
}
