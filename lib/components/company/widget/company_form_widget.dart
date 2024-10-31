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
    required this.initialPublicName,
    super.key,
  });

  final bool isDesk;
  final String? initialCompanyName;
  final String? initialPublicName;
  final String? initialEmail;
  final String? initialCode;
  final String? initialLink;

  @override
  State<CompanyFormWidget> createState() => _CompanyFormWidgetState();
}

class _CompanyFormWidgetState extends State<CompanyFormWidget> {
  late TextEditingController companyNameController;
  late TextEditingController publicNameController;
  late TextEditingController codeController;
  late TextEditingController emailController;
  late TextEditingController linkController;

  @override
  void initState() {
    companyNameController =
        TextEditingController(text: widget.initialCompanyName);
    publicNameController =
        TextEditingController(text: widget.initialPublicName);
    codeController = TextEditingController(text: widget.initialCode);
    emailController = TextEditingController(text: widget.initialEmail);
    linkController = TextEditingController(text: widget.initialLink);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyFormBloc, CompanyFormState>(
      // listener: (context, _) {
      //   if (_.formState == CompanyFormEnum.delete) {
      //     context.goNamed(KRoute.myDiscounts.name);
      //   }
      // },
      buildWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.image != current.image ||
          previous.deleteIsPossible != current.deleteIsPossible,
      builder: (context, _) {
        return BlocListener<CompanyWatcherBloc, CompanyWatcherState>(
          listener: (context, state) {
            if (companyNameController.text.isEmpty) {
              companyNameController.text = state.company.companyName ?? '';
              context
                  .read<CompanyFormBloc>()
                  .add(const CompanyFormEvent.started());
            }
            if (publicNameController.text.isEmpty) {
              publicNameController.text = state.company.publicName ?? '';
            }
            if (codeController.text.isEmpty) {
              codeController.text = state.company.code ?? '';
            }
            if (linkController.text.isEmpty) {
              linkController.text = state.company.link ?? '';
            }
          },
          listenWhen: (previous, current) =>
              _.formState == CompanyFormEnum.initial &&
              previous.company.id != current.company.id,
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
                          Padding(
                            padding: _.image.value == null
                                ? EdgeInsets.zero
                                : const EdgeInsets.only(
                                    left: KPadding.kPaddingSize24,
                                  ),
                            child: UserPhotoWidget(
                              key: KWidgetkeys.screen.company.photo,
                              imageBytes: _.image.value?.bytes,
                              onPressed: () => context
                                  .read<CompanyFormBloc>()
                                  .add(const CompanyFormEvent.imageUpdated()),
                              imageUrl: context
                                  .read<CompanyWatcherBloc>()
                                  .state
                                  .company
                                  .imageUrl,
                              // perimeter: KSize.kPixel72,
                              icon: KIcon.personEdit,
                              // background: AppColors.
                              // materialThemeKeyColorsPrimary,
                              // iconColor: AppColors.materialThemeBlack,
                            ),
                          ),
                          KSizedBox.kWidthSizedBox32,
                          Expanded(
                            child: Text(
                              context.l10n.dataEditing,
                              key: KWidgetkeys.screen.company.editText,
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
                          key: KWidgetkeys.screen.company.imageEditText,
                          textAlign: TextAlign.center,
                          style: AppTextStyle
                              .materialThemeBodyMediumNeutralVariant60,
                        ),
                      KSizedBox.kHeightSizedBox32,
                      _textField(
                        fieldKey: KWidgetkeys.screen.company.publicNameField,
                        controller: publicNameController,
                        labelText: context.l10n.brandName,
                        isRequired: true,
                        description: context.l10n.brandNameDescription,
                        onChanged: (text) => context
                            .read<CompanyFormBloc>()
                            .add(CompanyFormEvent.publicNameUpdated(text)),
                        isDesk: widget.isDesk,
                        errorText: _.publicName.error.value(context),
                      ),
                      KSizedBox.kHeightSizedBox32,
                      _textField(
                        fieldKey: KWidgetkeys.screen.company.companyNameField,
                        controller: companyNameController,
                        isRequired: true,
                        description: context.l10n.companyNameDescription,
                        labelText: context.l10n.companyName,
                        onChanged: (text) => context
                            .read<CompanyFormBloc>()
                            .add(CompanyFormEvent.companyNameUpdated(text)),
                        isDesk: widget.isDesk,
                        errorText: _.companyName.error.value(context),
                      ),
                      KSizedBox.kHeightSizedBox32,
                      _textField(
                        fieldKey: KWidgetkeys.screen.company.companyCodeField,
                        controller: codeController,
                        isRequired: true,
                        labelText: context.l10n.companyCode,
                        description: context.l10n.companyCodeDescription,
                        onChanged: (text) => context
                            .read<CompanyFormBloc>()
                            .add(CompanyFormEvent.codeUpdated(text)),
                        isDesk: widget.isDesk,
                        errorText: _.code.error.value(context),
                      ),
                      KSizedBox.kHeightSizedBox32,
                      _textField(
                        fieldKey: KWidgetkeys.screen.company.userEmailField,
                        controller: emailController,
                        isRequired: true,
                        labelText: KMockText.email,
                        enabled: false,
                        isDesk: widget.isDesk,
                        errorText: null,
                        showErrorText: false,
                      ),
                      KSizedBox.kHeightSizedBox32,
                      _textField(
                        fieldKey: KWidgetkeys.screen.company.linkField,
                        controller: linkController,
                        labelText: context.l10n.linkOnWebsite,
                        onChanged: (text) => context
                            .read<CompanyFormBloc>()
                            .add(CompanyFormEvent.linkUpdated(text)),
                        isDesk: widget.isDesk,
                        errorText: _.link.error.value(context),
                      ),
                      KSizedBox.kHeightSizedBox16,
                      SendingTextWidget(
                        textKey: KWidgetkeys.screen.company.submitingText,
                        failureText: _.failure?.value(context),
                        sendingText: context.l10n.changesSendInProgress,
                        successText: _.formState == CompanyFormEnum.success
                            ? context.l10n.dataIsUpdatedSuccess
                            : context.l10n.dataUnmodified,
                        showSuccessText: _.formState ==
                                CompanyFormEnum.success ||
                            _.formState == CompanyFormEnum.succesesUnmodified,
                        showSendingText:
                            _.formState == CompanyFormEnum.sendInProgress,
                      ),
                      KSizedBox.kHeightSizedBox16,
                      DoubleButtonWidget(
                        widgetKey: KWidgetkeys.screen.company.saveButton,
                        text: context
                                .read<CompanyWatcherBloc>()
                                .state
                                .company
                                .isEmpty
                            ? context.l10n.createAccount
                            : context.l10n.saveChangesProfile,
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
              KSizedBox.kHeightSizedBox8,
              if (context.read<CompanyWatcherBloc>().state.company.isEmpty)
                Text(
                  context.l10n.deleteCompanyEmptyMessage,
                  key: KWidgetkeys.screen.company.deleteNotEnabledText,
                  style: AppTextStyle.materialThemeBodyMediumNeutralVariant60,
                )
              else
                SendingTextWidget(
                  textKey: KWidgetkeys.screen.company.deleteNotEnabledText,
                  failureText: null,
                  sendingText: context.l10n.deleteCompanyLoadingMessage,
                  successText: context.l10n.deleteCompanyMessage,
                  showSuccessText: !(_.deleteIsPossible ?? true),
                  showSendingText: _.deleteIsPossible == null,
                  successTextAlign: TextAlign.start,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _textField({
    required String labelText,
    required Key fieldKey,
    required TextEditingController controller,
    required bool isDesk,
    required String? errorText,
    bool? showErrorText,
    bool? isRequired,
    String? description,
    void Function(String text)? onChanged,
    bool enabled = true,
  }) {
    return TextFieldWidget(
      widgetKey: fieldKey,
      isRequired: isRequired,
      enabled: enabled,
      controller: controller,
      labelText: labelText,
      description: description,
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
          context.read<CompanyFormBloc>().state.formState ==
              CompanyFormEnum.invalidData,
      isDesk: isDesk,
      onChanged: onChanged,
    );
  }

  Widget logoutButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      ButtonAdditionalWidget(
        key: KWidgetkeys.screen.company.logOutButton,
        text: context.l10n.logOut,
        picture: KIcon.logOut,
        align: Alignment.center,
        onPressed: () => context.dialog.showConfirmationDialog(
          isDesk: isDesk,
          title: context.l10n.logOutFromProfile,
          subtitle: context.l10n.logOutProfileQuestion,
          confirmText: context.l10n.logOut,
          confirmButtonBackground: AppColors.materialThemeKeyColorsSecondary,
          onPressed: () {
            context.read<AuthenticationBloc>().add(
                  AuthenticationLogoutRequested(),
                );
            // context.goNamed(KRoute.myDiscounts.name);
          },
          timer: false,
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
  }) {
    final enabled =
        (context.read<CompanyFormBloc>().state.deleteIsPossible ?? false) &&
            context.read<CompanyWatcherBloc>().state.company.isNotEmpty;
    return SecondaryButtonWidget(
      widgetKey: KWidgetkeys.screen.company.deleteButton,
      isDesk: isDesk,
      align: Alignment.center,
      style: KButtonStyles.borderNeutralButtonStyle.copyWith(
        backgroundColor: enabled
            ? null
            : const WidgetStatePropertyAll(
                AppColors.materialThemeKeyColorsNeutral,
              ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize16,
      ),
      text: context.l10n.deleteAccount,
      onPressed: enabled
          ? () => context.dialog.showConfirmationDialog(
                isDesk: isDesk,
                title: context.l10n.deleteProfile,
                subtitle: context.l10n.deleteProfileQuestion,
                confirmText: context.l10n.delete,
                confirmButtonBackground: AppColors.materialThemeRefErrorError60,
                onPressed: () {
                  context.read<CompanyFormBloc>().add(
                        const CompanyFormEvent.deleteCompany(),
                      );
                  // context.goNamed(KRoute.myDiscounts.name);
                },
                timer: false,
              )
          : null,
    );
  }

  @override
  void dispose() {
    companyNameController.dispose();
    codeController.dispose();
    emailController.dispose();
    linkController.dispose();
    super.dispose();
  }
}
