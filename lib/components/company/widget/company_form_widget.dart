import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared.dart';

class CompanyFormWidget extends StatefulWidget {
  const CompanyFormWidget({
    required this.isDesk,
    required this.initialCompanyName,
    required this.initialCode,
    required this.initialLink,
    required this.initialEmail,
    required this.photoURL,
    super.key,
    this.imageBytes,
  });

  final bool isDesk;
  final String? photoURL;
  final Uint8List? imageBytes;
  final String? initialCompanyName;
  final String? initialEmail;
  final String? initialCode;
  final String? initialLink;

  @override
  State<CompanyFormWidget> createState() => _CompanyFormWidgetState();
}

class _CompanyFormWidgetState extends State<CompanyFormWidget> {
  late TextEditingController companyNameController;
  late TextEditingController codeController;
  late TextEditingController emailController;
  late TextEditingController linkController;

  @override
  void initState() {
    companyNameController =
        TextEditingController(text: widget.initialCompanyName);
    codeController = TextEditingController(text: widget.initialCode);
    emailController = TextEditingController(text: widget.initialEmail);
    linkController = TextEditingController(text: widget.initialLink);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyWatcherBloc, CompanyWatcherState>(
      listener: (context, state) {
        if (companyNameController.text.isEmpty) {
          companyNameController.text = state.company.companyName ?? '';
          context.read<CompanyFormBloc>().add(const CompanyFormEvent.started());
        }
        if (codeController.text.isEmpty) {
          codeController.text = state.company.code ?? '';
        }
        if (linkController.text.isEmpty) {
          linkController.text = state.company.link ?? '';
        }
      },
      listenWhen: (previous, current) => previous.company != current.company,
      child: Column(
        children: [
          DecoratedBox(
            decoration: KWidgetTheme.boxDecorationHome
                .copyWith(color: AppColors.materialThemeKeyColorsNeutral),
            child: Padding(
              padding: widget.isDesk
                  ? const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize48,
                      horizontal: KPadding.kPaddingSize64,
                    )
                  : const EdgeInsets.all(
                      KPadding.kPaddingSize16,
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserPhotoWidget(
                        key: KWidgetkeys.screen.profile.photo,
                        imageBytes: widget.imageBytes,
                        onPressed: () => context
                            .read<CompanyFormBloc>()
                            .add(const CompanyFormEvent.imageUpdated()),
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
                    controller: companyNameController,
                    hint: context.l10n.companyName,
                    onChanged: (text) => context
                        .read<CompanyFormBloc>()
                        .add(CompanyFormEvent.companyNameUpdated(text)),
                    isDesk: widget.isDesk,
                    errorText: context
                        .read<CompanyFormBloc>()
                        .state
                        .companyName
                        .error
                        .value(context),
                    showErrorText:
                        context.read<CompanyFormBloc>().state.formState ==
                            CompanyFormEnum.invalidData,
                  ),
                  KSizedBox.kHeightSizedBox32,
                  _textField(
                    fieldKey: KWidgetkeys.screen.profile.lastNameField,
                    controller: codeController,
                    hint: context.l10n.companyCode,
                    onChanged: (text) => context
                        .read<CompanyFormBloc>()
                        .add(CompanyFormEvent.codeUpdated(text)),
                    isDesk: widget.isDesk,
                    errorText: context
                        .read<CompanyFormBloc>()
                        .state
                        .code
                        .error
                        .value(context),
                    showErrorText:
                        context.read<CompanyFormBloc>().state.formState ==
                            CompanyFormEnum.invalidData,
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
                  KSizedBox.kHeightSizedBox32,
                  _textField(
                    fieldKey: const Key(''),
                    controller: linkController,
                    hint: context.l10n.linkOnWebsite,
                    onChanged: (text) => context
                        .read<CompanyFormBloc>()
                        .add(CompanyFormEvent.linkUpdated(text)),
                    isDesk: widget.isDesk,
                    errorText: context
                        .read<CompanyFormBloc>()
                        .state
                        .link
                        .error
                        .value(context),
                    showErrorText:
                        context.read<CompanyFormBloc>().state.formState ==
                            CompanyFormEnum.invalidData,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  SendingTextWidget(
                    textKey: KWidgetkeys.screen.login.submitingText,
                    failureText: context
                        .read<CompanyFormBloc>()
                        .state
                        .failure
                        ?.value(context),
                    sendingText: context.l10n.dataSendInProgress,
                    successText:
                        context.read<CompanyFormBloc>().state.formState ==
                                CompanyFormEnum.success
                            ? context.l10n.dataIsUpdatedSuccess
                            : context.l10n.dataUnmodified,
                    showSuccessText:
                        context.read<CompanyFormBloc>().state.formState ==
                                CompanyFormEnum.success ||
                            context.read<CompanyFormBloc>().state.formState ==
                                CompanyFormEnum.succesesUnmodified,
                    showSendingText:
                        context.read<CompanyFormBloc>().state.formState ==
                            CompanyFormEnum.sendInProgress,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  DoubleButtonWidget(
                    widgetKey: KWidgetkeys.screen.profile.saveButton,
                    text: context.l10n.saveChangesProfile,
                    color: AppColors.materialThemeKeyColorsSecondary,
                    textColor: AppColors.materialThemeWhite,
                    icon: KIcon.check
                        .copyWith(color: AppColors.materialThemeWhite),
                    deskPadding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize12,
                      horizontal: KPadding.kPaddingSize32,
                    ),
                    deskIconPadding: KPadding.kPaddingSize12,
                    onPressed: () => context
                        .read<CompanyFormBloc>()
                        .add(const CompanyFormEvent.save()),
                    isDesk: widget.isDesk,
                    mobTextWidth: double.infinity,
                    mobVerticalTextPadding: KPadding.kPaddingSize16,
                    mobIconPadding: KPadding.kPaddingSize16,
                  ),
                ],
              ),
            ),
          ),
          if (widget.isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox48,
          if (widget.isDesk)
            Row(
              children: [
                Expanded(
                  child: logoutButton(
                    context: context,
                    isDesk: widget.isDesk,
                  ),
                ),
                KSizedBox.kWidthSizedBox40,
                Expanded(
                  child: deleteButton(
                    context: context,
                    isDesk: widget.isDesk,
                  ),
                ),
              ],
            )
          else ...[
            logoutButton(context: context, isDesk: widget.isDesk),
            KSizedBox.kHeightSizedBox16,
            deleteButton(context: context, isDesk: widget.isDesk),
          ],
        ],
      ),
    );
  }

  Widget _textField({
    required String hint,
    required Key fieldKey,
    required TextEditingController controller,
    required bool isDesk,
    required String? errorText,
    required bool showErrorText,
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
      errorText: errorText, showErrorText: showErrorText,
      isDesk: isDesk,
      onChanged: onChanged,
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
        deskPadding: const EdgeInsets.only(
          top: KPadding.kPaddingSize16,
          bottom: KPadding.kPaddingSize16,
          left: KPadding.kPaddingSize60,
        ),
        expanded: true,
        borderColor: AppColors.materialThemeRefNeutralNeutral80,
        mobPadding: const EdgeInsets.only(
          top: KPadding.kPaddingSize16,
          bottom: KPadding.kPaddingSize16,
          right: KPadding.kPaddingSize40,
        ),
        iconPadding: KPadding.kPaddingSize16,
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
          deleteEvent: () => context.read<CompanyFormBloc>().add(
                const CompanyFormEvent.deleteCompany(),
              ),
        ),
      );

  @override
  void dispose() {
    companyNameController.dispose();
    codeController.dispose();
    emailController.dispose();
    linkController.dispose();
    super.dispose();
  }
}
