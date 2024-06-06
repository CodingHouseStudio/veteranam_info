part of 'body/help_find_job_body_contact_widget.dart';

List<Widget> _respondContainerWidgetList({
  required BuildContext context,
  required bool isDesk,
  required VoidCallback onNextPressed,
}) {
  return [
    Text(
      key: KWidgetkeys.screen.helpFindJob.username,
      context.read<AuthenticationBloc>().state.user?.name ?? KMockText.userName,
      style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.emailText,
        context.l10n.email,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.screen.helpFindJob.emailField,
      onChanged: (value) => context
          .read<HelpFindJobBloc>()
          .add(HelpFindJobEvent.emailUpdated(value)),
      hintText: context.l10n.emailHint,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.phoneNumberText,
        context.l10n.phoneNumber,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.screen.helpFindJob.phoneNumberField,
      onChanged: (value) => context
          .read<HelpFindJobBloc>()
          .add(HelpFindJobEvent.phoneNumberUpdated(value)),
      hintText: context.l10n.phoneNumberHint,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.resume,
        context.l10n.resume,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextButton.icon(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        const Duration(seconds: 1);
        if (!context.mounted) return;
        if (result != null) {
          final file = File(result.files.single.path!);
          context
              .read<HelpFindJobBloc>()
              .add(HelpFindJobEvent.resumeUploaded(file));
        }
      },
      style: KButtonStyles.borderButtonStyle,
      icon: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
        ).copyWith(
          left: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
        ),
        child: KIcon.attachFile,
      ),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          key: KWidgetkeys.screen.helpFindJob.upload,
          context.l10n.upload,
          style: isDesk
              ? AppTextStyle.text24.copyWith(
                  decoration: TextDecoration.underline,
                )
              : AppTextStyle.text16.copyWith(
                  decoration: TextDecoration.underline,
                ),
        ),
      ),
    ),
    if (context.watch<HelpFindJobBloc>().state.resume != null)
      Text(context.watch<HelpFindJobBloc>().state.resume!.path),
    if (isDesk) KSizedBox.kHeightSizedBox10 else KSizedBox.kHeightSizedBox8,
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize32,
            right: KPadding.kPaddingSize16,
          ),
          child: CheckPointSingleWidget(
            key: KWidgetkeys.screen.helpFindJob.checkPoint,
            onChanged: null,
          ),
        ),
        Text(
          key: KWidgetkeys.screen.helpFindJob.noResume,
          context.l10n.noResume,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
      ],
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    if (isDesk)
      Row(
        children: [
          Expanded(
            child: cancelButton(context: context, isDesk: true),
          ),
          KSizedBox.kWidthSizedBox73,
          Expanded(
            child: nextButton(
              context: context,
              isDesk: true,
              onNextPressed: onNextPressed,
            ),
          ),
        ],
      )
    else ...[
      cancelButton(context: context, isDesk: false),
      KSizedBox.kHeightSizedBox16,
      nextButton(
        context: context,
        isDesk: false,
        onNextPressed: onNextPressed,
      ),
    ],
    if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox24,
  ];
}

Widget cancelButton({required BuildContext context, required bool isDesk}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.helpFindJob.cancel,
      text: context.l10n.cancel,
      onPressed: null,
      isDesk: isDesk,
      backgroundColor: AppColors.materialThemeRefTertiaryTertiary100,
    );

Widget nextButton({
  required BuildContext context,
  required bool isDesk,
  required VoidCallback onNextPressed,
}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.helpFindJob.send,
      text: context.l10n.next,
      onPressed: onNextPressed,
      isDesk: isDesk,
      backgroundColor: AppColors.materialThemeKeyColorsNeutralVariant,
    );
